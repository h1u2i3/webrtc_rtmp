lib = "/Users/xiaohui/Ruby/webrtc_rtmp/lib"  # => "/Users/xiaohui/Ruby/webrtc_rtmp/lib"
$:.unshift(lib) unless $:.include?(lib)      # => ["/Users/xiaohui/Ruby/webrtc_rtmp/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/seeing_is_believing-3.2.0/lib", "/usr/local/Cellar/rbenv/1.1.0/rbenv.d/exec/gem-rehash", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/did_you_mean-1.1.0/lib", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/site_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby/2.4.0/x86_64-darwin16", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/vendor_ruby", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0", "/Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/x86_64-darwin16"]
require "webrtc_rtmp"                        # => true

worker = WebrtcRtmp::Worker.new(  # => WebrtcRtmp::Worker
  server_ip: "127.0.0.1",         # => "127.0.0.1"
  audio_port: 8001,               # => 8001
  video_port: 8003,               # => 8003
  stream_id: "live_msft"          # => "live_msft"
)                                 # => #<WebrtcRtmp::Worker:0x007fb04b813690 @container=#<WebrtcRtmp::Container:0x007fb04b812790 @pids=[], @video_ports=[], @audio_ports=[], @workers=[]>, @stream_id="live_msft", @server_ip="127.0.0.1", @audio_port=8001, @video_port=8003>

worker.start_stream  # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - .sdp/live_msft20170928-92296-1lg88m

# ~> Errno::ENOENT
# ~> No such file or directory @ rb_sysopen - .sdp/live_msft20170928-92296-1lg88m
# ~>
# ~> /Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/tempfile.rb:133:in `initialize'
# ~> /Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/tempfile.rb:133:in `open'
# ~> /Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/tempfile.rb:133:in `block in initialize'
# ~> /Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/tmpdir.rb:130:in `create'
# ~> /Users/xiaohui/.rbenv/versions/2.4.1/lib/ruby/2.4.0/tempfile.rb:131:in `initialize'
# ~> /Users/xiaohui/Ruby/webrtc_rtmp/lib/webrtc_rtmp/worker.rb:33:in `new'
# ~> /Users/xiaohui/Ruby/webrtc_rtmp/lib/webrtc_rtmp/worker.rb:33:in `start_stream'
# ~> /Users/xiaohui/Ruby/webrtc_rtmp/test.rb:12:in `<main>'
