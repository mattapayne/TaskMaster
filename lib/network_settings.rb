module TaskMaster
  class NetworkSettings
    
    def id(ns_id)
      @id = ns_id
    end
    
    def name(ns_name)
      @name = ns_name
    end
    
    def to_xml(builder)
      builder.NetworkSettings do
        builder.Id @id if @id
        builder.Name @name if @name
      end
    end
    
  end
end