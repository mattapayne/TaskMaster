module TaskMaster
  class TaskSettings < BaseSettings
    
    def to_xml(builder)
      builder.Settings do
        super(builder)
      end
    end
    
  end
end