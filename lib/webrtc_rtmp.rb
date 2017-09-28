require "terminal-table"

require "webrtc_rtmp/version"
require "webrtc_rtmp/worker"
require "webrtc_rtmp/container"
require "webrtc_rtmp/command"

module WebrtcRtmp
  # find a way to manage the rtmp background command job
  # 1. start at any time to generate a rtmp stream with ffmpeg
  # 2. can manage all the available ffmpeg stream
  # 3. can stop the selected ffmpeg stream
  # 4. can restart the selected ffmpeg stream
  def self.show_streams
    resources = Container.instance.workers
    if resources.empty?
      puts "There are no stream running ..."
    else
      tables = Terminal::Table.new(
        headings: ["Stream Name", "Audio Port", "Video Port", "Running", "Pid"]
      ) do |t|
        resources.each do |resource|
          t << [resource.stream_id, resource.audio_port, resource.video_port, resource.running, resource.pid]
        end
      end
      puts tables
    end
  end

  # the ports start from 8001, and audio port shoud have 2 port
  # with video
  # the default server_ip is just 127.0.0.1
  # eg:
  # start: audio: 8001, video: 9001
  #        audio: 8002, video: 9002
  # default don't use any log just because the log message should be huge
  def self.start_stream(stream, log = "/dev/null", resource)
    raise("The stream name has been used...") unless Container.instance.name_available?(stream)
    resource ||= Container.instance.available_resource
    worker = WebrtcRtmp::Worker.new(          # => WebrtcRtmp::Worker
      server_ip: "127.0.0.1",                 # => "127.0.0.1"
      audio_port: resource[:audio],           # => 8001
      video_port: resource[:video],           # => 8003
      stream_id:  stream                      # => "live_msft"
    )
    # ok, let's just start the stream
    worker.start_stream(log)
  end

  # stop the stream
  # we should clear the resource the stream have
  def self.stop_stream(stream)
    WebrtcRtmp.find_stream(stream).stop_stream
  end

  # just restart the stream
  def self.restart_stream(stream)
    WebrtcRtmp.find_stream(stream).restart_stream
  end

  # just find the stream worker by the stream name
  def self.find_stream(stream)
    Worker.find_by_stream_id(stream) || raise("No stream, please check your stream name")
  end
end
