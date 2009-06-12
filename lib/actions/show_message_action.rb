module TaskMaster
  class ShowMessageAction < Action
    
    def title(title_text)
      @title = title_text
    end
    
    def body(body_text)
      @body = body_text
    end
    
    def to_xml(builder)
      builder.ShowMessage(id_attrs) do
        builder.Title @title if @title
        builder.Body @body if @body
      end
    end
    
    def valid?
      valid = true
      unless (@title && !@title.blank?)
        add_error("#{self.class.name}: Title property is invalid.")
        valid = false
      end
      unless (@body && !@body.blank?)
        add_error("#{self.class.name}: Body property is invalid.")
        valid = false
      end
      valid
    end
    
  end
end