module TaskMaster
  class LogonTrigger < Trigger
    
    def userid(id)
      @userid = id
    end
    
    def delay(duration)
      @delay = Duration.new(duration)
    end
    
    def valid?
      (@userid && !@userid.to_s.empty?)
    end
    
    def to_xml(builder)
      builder.LogonTrigger do
        super(builder)
        builder.UserId @userid if @userid
        builder.Delay @delay.to_s if @delay
      end
    end
  end
end