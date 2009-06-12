module TaskMaster
  class IdleSettings
    
    def duration(duration)
      @duration = Duration.new(duration)
    end
    
    def restart_on_idle(restart)
      @restart_on_idle = restart
    end
    
    def terminate_on_idle_end(stop)
      @terminate_on_idle_end = stop
    end
    
    def wait_timeout(duration)
      @wait_timeout = Duration.new(duration)
    end
    
    def to_xml(builder)
      builder.IdleSettings do
        builder.WaitTimeout @wait_timeout.to_s if @waittimeout
        builder.Duration @duration.to_s if @duration
        builder.TerminateOnIdleEnd @terminate_on_idle_end if @terminate_on_idle_end
        builder.RestartOnIdle @restart_on_idle if @restart_on_idle
      end
    end
    
  end
end