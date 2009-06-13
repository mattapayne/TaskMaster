require 'cgi'

module TaskMaster
  class EventTrigger < Trigger
    
    class QueryValue
      
      def value(qv_value)
        @value = qv_value
      end
      
      def name(qv_name)
        @name = qv_name
      end
      
      def to_xml(builder)
        name_hash = @name.blank? ? nil : {:name => @name}
        builder.Value(@value, name_hash) if @value
      end
      
      def valid?
        (@value && !@value.to_s.empty?)
      end
      
    end
    
    def initialize
      @query_values = []
    end
    
    def delay(duration)
      @delay = Duration.new(duration)
    end
    
    def subscription(sub)
      @subscription = sub
    end
    
    def valid?
      (@subscription && !@subscription.blank?)
    end
    
    def value_query(&block)
      if block_given?
        qv = QueryValue.new
        qv.instance_eval(&block)
        unless qv.valid?
          raise "Invalid Query Value"
        end
        @query_values << qv
      end
    end
    
    def to_xml(builder)
      builder.EventTrigger do
        super(builder)
        builder.Subscription CGI.escapeHTML(@subscription) if @subscription
        builder.Delay @delay.to_s if @delay
        unless @query_values.empty?
          builder.ValueQueries do
            @query_values.each {|qv| qv.to_xml(builder)}
          end
        end
      end
    end
  end
end