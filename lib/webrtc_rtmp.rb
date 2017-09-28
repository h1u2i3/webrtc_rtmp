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
end
