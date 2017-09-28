RSpec.describe WebrtcRtmp::Container do

  it "should be a singleton class" do
    expect { WebrtcRtmp::Container.new }.to raise_error(NoMethodError)
  end

  it "should initialize with empty audio_ports and video_ports" do
    instance = WebrtcRtmp::Container.instance
    expect(instance.audio_ports).to be_empty
    expect(instance.video_ports).to be_empty
  end

end
