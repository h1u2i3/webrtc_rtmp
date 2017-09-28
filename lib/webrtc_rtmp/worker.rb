require 'ipaddr'
require 'tempfile'

require_relative 'helper'
require_relative 'ffmpeg_builder'

module WebrtcRtmp
  # e, that is the ip address regexp to check the server ip
  # just to make sure anyone type the wrong ip address
  class Worker
    include WebrtcRtmp::Helper

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

    def start_stream
      if @container.resource_available?
        @stream = Tempfile.new([@stream_id, '.sdp'])
        @stream.write(FFmpegBuilder.new(@server_ip, @audio_port, @video_port).gen_sdp)
        @pid = Command.run("ffmpeg -r 25  -i #{@stream.path} -c copy -f flv rtmp://localhost/live/#{@stream_id}")
        @container.add_worker(self)
      else
        raise(ArgumentError, "The audio or video resource is unavailable")
      end
    end

    def stop_stream
      Process.kill(:SIGINT, @pid)
      @stream.unlink
      @containter.remove_worker(self)
    end
  end
end
