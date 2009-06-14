module TaskMaster
  
  class StateChange
    
    STATE_CHANGES = ["ConsoleConnect", "ConsoleDisconnect", "RemoteConnect", "RemoteDisconect", 
     "SessionLock", "SessionUnlock"].freeze
    
    def initialize(state)
      unless STATE_CHANGES.include?(state.to_s)
        raise ArgumentError.new("Invalid session state change specified: #{state}. Must be one of #{STATE_CHANGES.to_sentence}")
      end
      @change = state
    end
    
    def self.console_connect
      "ConsoleConnect"
    end
    
    def self.console_disconnect
      "ConsoleDisconnect"
    end
    
    def self.remote_connect
      "RemoteConnect"
    end
    
    def self.remote_disconnect
      "RemoteDisconect"
    end
    
    def self.session_lock
      "SessionLock"
    end
    
    def self.session_unlock
      "SessionUnlock"
    end
    
    def to_s
      @change
    end
    
  end
  
end