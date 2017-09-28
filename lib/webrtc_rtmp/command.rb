module WebrtcRtmp
  # a shell command runner, should be support the log message
  class Command
    # should support for the log
    def self.run(command, options = {})
      log = options[:log] || $stdout
      spawn(command, out: log)
    end
  end
end
