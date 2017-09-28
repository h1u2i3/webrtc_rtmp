require 'singleton'

module WebrtcRtmp
  class Container
    # the container of all the ports the workers use
    # should be a single instance class
    # contains values of the ports and other resource
    include Singleton

    attr_accessor :audio_ports, :video_ports

    def initialize
      @workers = @audio_ports = @video_ports = @pids = []
    end

    # add a worker to the worker list
    def add_worker(worker)
      @workers << worker
      @audio_ports << worker.audio_port
      @video_ports << worker.video_port
      @pids << worker.pid
    end

    # remove a worker from the worker list
    def remove_worker(worker)
      pid, audio_port, video_port = worker.pid, worker.audio_port, worker.video_port
      @workers.delete(worker) if @workers.include?(worker)
      @audio_ports.delete(audio_port) if audio_port_exist?(audio_port)
      @video_ports.delete(video_port) if video_port_exist?(video_port)
      @pids.delete(pid) if pid.exist?(pid)
    end

    # create the exist? check method
    [:pid, :audio_port, :video_port].each do |name|
      define_method(:"#{name.to_s}_exist?") do |arg|
        instance_variable_get(:"@#{name.to_s}s").include?(arg)
      end
    end

    def resource_available?
      !audio_port_exist?(@audio_port) &&
      !video_port_exist?(@video_port)
    end
  end
end
