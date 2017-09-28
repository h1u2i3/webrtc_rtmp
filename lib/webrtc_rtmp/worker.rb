require 'ipaddr'
require 'tempfile'

require_relative 'helper'
require_relative 'ffmpeg_builder'

module WebrtcRtmp
  # e, that is the ip address regexp to check the server ip
  # just to make sure anyone type the wrong ip address
  class Worker
    include WebrtcRtmp::Helper

    attr_reader :running
    attr_accessor :stream_id, :audio_port, :video_port, :pid

    # find a worker by the stream_id, if the worker still exist
    # so we should import unique stream id to the worker
    # this should be sure
    def self.find_by_stream_id(stream_id)
      container = Container.instance
      container.workers.find { |w| w.stream_id == stream_id }
    end

    def initialize(options)
      stream_id = check_string(String(options[:stream_id])) || raise_argument_error(:stream_id)
      server_ip = check_ip(String(options[:server_ip])) || raise_argument_error(:server_ip)
      audio_port = check_port(Integer(options[:audio_port])) || raise_argument_error(:audio_port)
      video_port = check_port(Integer(options[:video_port])) || raise_argument_error(:video_port)
      @container = Container.instance
      @stream_id, @server_ip, @audio_port, @video_port = stream_id, server_ip, audio_port, video_port
    end

    def start_stream(logger)
      if @container.resource_available?(@audio_port, @video_port)
        prepare_sdp

        # just a simple way to do the system command
        command = <<~EOF
          ffmpeg -r 25 \
          -loglevel quiet \
          -protocol_whitelist 'file,udp,sdp,rtp' \
          -i #{@stream.path} \
          -c copy -f flv \
          rtmp://localhost/live/#{@stream_id}
        EOF

        @pid = Command.run(command, log: logger)
        @logger = logger
        @running = true
        @container.add_worker(self)

        # just return self
        self
      else
        raise(ArgumentError, "The audio or video resource is unavailable")
      end
    end

    # simple stop method
    def stop_stream
      Process.kill(:SIGINT, @pid)
      @running = false
      @stream.unlink
      @container.remove_worker(self)
    end

    # just implement a simple restart method
    def restart_stream
      stop_stream
      start_stream(@logger || "/dev/null")
    end

    # is_running check
    def is_running?
      @running
    end

    private

      def prepare_sdp
        @stream = Tempfile.new([@stream_id, '.sdp'])
        @stream.write(FFmpegBuilder.new(@server_ip, @audio_port, @video_port).gen_sdp)
        @stream.rewind
      end
  end
end
