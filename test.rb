lib = "/Users/xiaohui/Ruby/webrtc_rtmp/lib"  # => "/Users/xiaohui/Ruby/webrtc_rtmp/lib"
$:.unshift(lib) unless $:.include?(lib)      # => ["/Users/xiaohui/Ruby/webrtc_rtmp/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/usr/local/Cellar/rbenv/1.1.0/rbenv.d/exec/gem-rehash", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/did_you_mean-1.1.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/x86_64-darwin16"]
require "webrtc_rtmp"                        # => true


WebrtcRtmp.start_stream("hello_world")  # => [#<WebrtcRtmp::Worker:0x007fd81a016608 @container=#<WebrtcRtmp::Container:0x007fd81a0168b0 @pids=[...], @video_ports=[...], @audio_ports=[...], @workers=[...]>, @stream_id="hello_world", @server_ip="127.0.0.1", @audio_port=8868, @video_port=9774, @stream=#<Tempfile:/var/folders/nv/z44qthvj3ml0wv4nys639g2c0000gn/T/hello_world20170928-13376-c6vr46.sdp>, @pid=13379, @running=true>, 8868, 9774, 13379]

# !> ffmpeg version 3.3 Copyright (c) 2000-2017 the FFmpeg developers
# !>   built with Apple LLVM version 8.1.0 (clang-802.0.41)
# !>   configuration: --prefix=/usr/local/Cellar/ffmpeg/3.3 --enable-shared --enable-pthreads --enable-gpl --enable-version3 --enable-hardcoded-tables --enable-avresample --cc=clang --host-cflags= --host-ldflags= --enable-libmp3lame --enable-libx264 --enable-libxvid --enable-opencl --disable-lzma --enable-vda
# !>   libavutil      55. 58.100 / 55. 58.100
# !>   libavcodec     57. 89.100 / 57. 89.100
# !>   libavformat    57. 71.100 / 57. 71.100
# !>   libavdevice    57.  6.100 / 57.  6.100
# !>   libavfilter     6. 82.100 /  6. 82.100
# !>   libavresample   3.  5.  0 /  3.  5.  0
# !>   libswscale      4.  6.100 /  4.  6.100
# !>   libswresample   2.  7.100 /  2.  7.100
# !>   libpostproc    54.  5.100 / 54.  5.100
# !> [sdp @ 0x7fca0d807800] Could not find codec parameters for stream 1 (Video: h264, none): unspecified size
# !> Consider increasing the value for the 'analyzeduration' and 'probesize' options
# !> Guessed Channel Layout for Input Stream #0.0 : mono
# !> Input #0, sdp, from '/var/folders/nv/z44qthvj3ml0wv4nys639g2c0000gn/T/hello_world20170928-13376-c6vr46.sdp':
# !>   Metadata:
# !>     title           : Nginx Media Server
# !>   Duration: N/A, bitrate: 64 kb/s
# !>     Stream #0:0: Audio: pcm_mulaw, 8000 Hz, mono, s16, 64 kb/s
# !>     Stream #0:1: Video: h264, none, 90k tbr, 90k tbn, 180k tbc
# !> [tcp @ 0x7fca0c511080] Connection to tcp://localhost:1935 failed (Connection refused), trying next address
# !> [tcp @ 0x7fca0c511080] Connection to tcp://localhost:1935 failed: Connection refused
# !> [rtmp @ 0x7fca0c510ec0] Cannot open connection tcp://localhost:1935
# !> rtmp://localhost/live/hello_world: Connection refused
