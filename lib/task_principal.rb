module TaskMaster
  class TaskPrincipal
    
    def display_name(name)
      @display_name = name
    end
    
    def groupid(id)
      @groupid = id
    end
    
    def logon_type(type)
      @logon_type = LogonType.new(type)
    end
    
    def userid(id)
      @userid = id
    end
    
    def to_xml(builder)
      builder.Principals do
        builder.Principal do
          builder.UserId @userid if @userid
          builder.GroupId @groupid if @groupid
          builder.LogonType @logon_type if @logon_type
          builder.DisplayName @display_name if @display_name
        end
      end
    end
    
  end
end