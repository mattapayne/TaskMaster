module TaskMaster
  class Action
    
    def id(action_id)
      @id = action_id
    end
    
    def valid?
      true
    end
    
    def errors
      valid?
      @errors ||= []
    end
    
    def to_xml(builder)
      builder
    end
    
    def self.get(type)
      if type.blank? || !action_types.keys.include?(type.to_sym)
        raise ArgumentError.new("Invalid action type: #{type}. Must be one of #{action_types.keys.to_sentence}")
      end
      return action_types[type.to_sym].new
    end
    
    protected
    
    def add_error(message)
      (@errors ||= []) << message
    end
    
    def id_attrs
      (@id && !@id.nil?) ? {:id => @id} : {}
    end
    
    private
    
    def self.action_types
      { :com => ComAction, :exec => ExecAction, :email => EmailAction, :show_message => ShowMessageAction }
    end
    
  end
end