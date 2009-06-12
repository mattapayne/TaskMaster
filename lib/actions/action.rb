module TaskMaster
  class Action
    
    ACTION_TYPES = [:com, :exec, :email, :show_message].freeze
        
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
      if type.blank? || !ACTION_TYPES.include?(type.to_sym)
        raise ArgumentError.new("Invalid action type: #{type}. Must be one of #{ACTION_TYPES.to_sentence}")
      end
      action = nil
      case type.to_sym
        when :exec
          action = ExecAction.new
        when :com
          action = ComAction.new
        when :show_message
          action = ShowMessageAction.new
        when :email
          action = EmailAction.new
      end
      action
    end
    
    protected
    
    def add_error(message)
      (@errors ||= []) << message
    end
    
    def id_attrs
      (@id && !@id.nil?) ? {:id => @id} : {}
    end
    
  end
end