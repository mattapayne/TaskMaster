module TaskMaster
  class EmailAction < Action
    
    class HeaderField
      
      MAX_HEADER_FIELDS = 32
      
      def name(field_name)
        @name = field_name
      end
      
      def value(field_value)
        @value = field_value
      end
      
      def to_xml(builder)
        builder.HeaderField do
          builder.Name @name if @name
          builder.Value @value if @value
        end
      end
      
      def valid?
        (@name && !@name.blank?)
      end
      
    end
    
    class Attachment
      
      MAX_ATTACHMENTS = 8
      
      def file(f)
        @file = f
      end
      
      def to_xml(builder)
        builder.File @file if @file
      end
      
      def valid?
        (@file && !@file.empty?)
      end
      
    end
    
    def initialize
      @header_fields = []
      @attachments= []
    end
    
    def valid?
      unless (@server && !@server.blank?)
        add_error("#{self.class.name}: Server property is not valid.")
        return false
      end
      true
    end
    
    def server(server_name)
      @server = server_name
    end
    
    def subject(subj)
      @subject = subj
    end
    
    def to(recipient)
      @to = recipient
    end
    
    def cc(cc_recip)
      @cc = cc_recip
    end
    
    def bcc(bcc_recip)
      @bcc = bcc_recip
    end
    
    def reply_to(reply)
      @reply_to = reply
    end
    
    def from(sender)
      @from = sender
    end
    
    def header_field(&block)
      if block_given?
        if @header_fields.size >= HeaderField::MAX_HEADER_FIELDS
          raise "You can only specify up to #{HeaderField::MAX_HEADER_FIELDS} header fields"
        end
        header_field = HeaderField.new
        header_field.instance_eval(&block)
        unless header_field.valid?
          raise "Invalid header field"
        end
        @header_fields << header_field
      end
    end
    
    def body(email_body)
      @body = email_body
    end
    
    def attachment(&block)
      if block_given?
        if @attachments.size < Attachment::MAX_ATTACHMENTS
          att = Attachment.new
          att.instance_eval(&block)
          unless att.valid?
            raise "Invalid file attachment"
          end
          @attachments << att
        else
          raise "You are not allowed to have more than #{Attachment::MAX_ATTACHMENTS}"
        end
      end
    end
    
    def to_xml(builder)
        builder.SendEmail(id_attrs) do
          builder.Server @server if @server
          builder.Subject @subject if @subject
          builder.To @to if @to
          builder.Cc @cc if @cc
          builder.Bcc @bcc if @bcc
          builder.From @from if @from
          builder.ReplyTo @reply_to if @reply_to
          unless @header_fields.empty?
            builder.HeaderFields do
              @header_fields.each {|hf| hf.to_xml(builder)}
            end
          end
          unless @attachments.empty?
            builder.Attachments do
              @attachments.each {|a| a.to_xml(builder)}
            end
          end
        end
    end
    
  end

end