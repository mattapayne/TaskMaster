module TaskMaster
  class SessionStateChangeTrigger < Trigger 
    
    STATE_CHANGES = ["ConsoleConnect", "ConsoleDisconnect", "RemoteConnect", "RemoteDisconect", 
     "SessionLock", "SessionUnlock"].freeze
    
    def userid(id)
      @userid = id
    end
    
    def delay(duration)
      @delay = Duration.new(duration)
    end
    
    def state_change(change)
      unless STATE_CHANGES.include?(change.to_sym)
        raise "Invalid session state change specified: #{change}. Must be one of #{STATE_CHANGES.to_sentence}"
      end
      @change = change
    end
    
    def valid?
      (@userid && !@userid.to_s.empty?) &&
        (@change && !@change.to_s.empty?)
    end
    
    def to_xml(builder)
      builder.SessionStateChangeTrigger do
        super(builder)
        builder.UserId @userid if @userid
        builder.Delay @delay.to_s if @delay
        builder.StateChange STATE_CHANGES[@change.to_sym]
      end
    end
  end
end