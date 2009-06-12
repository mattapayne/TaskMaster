module TaskMaster
  class BootTrigger < Trigger

    def delay(duration)
      @delay = Duration.new(duration)
    end
    
    def to_xml(builder)
      builder.BootTrigger do
        super(builder)
        builder.Delay @delay.to_s if @delay
      end
    end
  end
end