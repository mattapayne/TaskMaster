module TaskMaster
  class IdleTrigger < Trigger
    
    def to_xml(builder)
      builder.IdleTrigger do
        super(builder)
      end
    end
  end
end