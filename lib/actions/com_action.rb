module TaskMaster
  class ComAction < Action
    
    GUID_REGEX = /[A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12}/
    
    def class_id(classid)
      @classid = classid
    end
    
    def data(action_data)
      @data = action_data
    end
    
    def to_xml(builder)
      builder.ComHandler(id_attrs) do
        builder.ClassId @classid if @classid
        builder.Data @data if @data
      end
    end
    
    def valid?
      unless (@classid && !@classid.blank? && classid_is_a_guid?)
        add_error("#{self.class.name}: Class ID is not valid.")
        return false
      end
      true
    end
    
    private
    
    def classid_is_a_guid?
      !(GUID_REGEX =~ @classid).nil?
    end
    
  end
end