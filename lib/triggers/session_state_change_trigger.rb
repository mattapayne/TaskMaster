module TaskMaster
  class SessionStateChangeTrigger < Trigger 
    
    def userid(id)
      @userid = id
    end
    
    def delay(duration)
      @delay = Duration.new(duration)
    end
    
    def state_change(change)
      @change = StateChange.new(change) 
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
        builder.StateChange @change.to_s if @change
      end
    end
  end
end