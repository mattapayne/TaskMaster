module TaskMaster
  class LogonType
    
    LOGON_TYPES = ["S4U", "Password", "InteractiveToken"].freeze
    
    def initialize(type)
      unless LOGON_TYPES.include?(type.to_s)
        raise ArgumentError.new("Invalid logon type: #{type}. Must be one of #{LOGON_TYPES.to_sentence}")
      end
      @type = type
    end
    
    def self.s4u
      "S4U"
    end
    
    def self.password
      "Password"
    end
    
    def self.interactive_token
      "InteractiveToken"
    end
    
    def to_s
      @type
    end
    
  end
end