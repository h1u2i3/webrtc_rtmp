require 'ipaddr'

module WebrtcRtmp
  # just a class to build the ffmpegg sdp and the run command
  class FFmpegBuilder
    include WebrtcRtmp::Helper

    def initialize(ip, audio, video)
      ip = check_ip(String(ip)) || raise_argument_error(:ip)
      audio = check_port(Integer(audio)) || raise_argument_error(:audio_port)
      video = check_port(Integer(video)) || raise_argument_error(:video_port)
      @ip, @audio, @video = ip, audio, video
    end

    def gen_sdp
      sdp_content = <<-EOF
        v=0
        o=- 2 2 IN IP4 #{@ip}
        s=Nginx Media Server
        t=0 0
        a=sendrecvonly
        c=IN IP4 127.0.0.1
        m=audio #{@audio} RTP/AVP 0
        a=rtpmap:0 PCMU/8000
        m=video #{@video} RTP/AVP 100
        a=rtpmap:100 H264/90000
        a=fmtp:96 packetization-mode=1
      EOF
    end
  end
end
