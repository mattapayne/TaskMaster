module TaskMaster
  class TaskPrincipal
    
    LOGON_TYPES = ["S4U", "Password", "InteractiveToken"].freeze
    
    def display_name(name)
      @display_name = name
    end
    
    def groupid(id)
      @groupid = id
    end
    
    def logon_type(type)
      unless LOGON_TYPES.include?(type.to_s)
        raise "Invalid logon type: #{type}. Must be one of #{LOGON_TYPES.to_sentence}"
      end
      @logon_type = type.to_s
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