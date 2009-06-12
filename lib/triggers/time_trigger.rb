module TaskMaster
  class TimeTrigger < Trigger
    
    def random_delay(duration)
      @delay = Duration.new(duration)
    end
    
    def to_xml(builder)
      builder.TimeTrigger do
        super(builder)
        builder.RandomDelay @delay.to_s if @delay
      end
    end
    
  end
end