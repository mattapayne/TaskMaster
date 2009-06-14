require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class RepetitionTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    setup do
      @builder = mock()
      @rep = Repetition.new
    end
    
    should "create a Repetition element" do
      @builder.expects(:Repetition)
      @rep.to_xml(@builder)
    end
    
    should "create a Duration element if duration is set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:Duration)
      end
      @rep.duration 1.day
      @rep.to_xml(@builder)
    end
    
    should "NOT create a Duration element if duration is NOT set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:Duration).never
      end
      @rep.to_xml(@builder)
    end
    
    should "create an Interval element if interval is set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:Interval)
      end
      @rep.interval 1.day
      @rep.to_xml(@builder)
    end
    
    should "NOT create an Interval element if interval is NOT set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:Interval).never
      end
      @rep.to_xml(@builder)
    end
    
    should "create an StopAtDurationEnd element if stop_at_duration_end is set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:StopAtDurationEnd)
      end
      @rep.stop_at_duration_end true
      @rep.to_xml(@builder)
    end
    
    should "NOT create an StopAtDurationEnd element if stop_at_duration_end is NOT set" do
      @builder.stubs(:Repetition) do
        @builder.expects(:StopAtDurationEnd).never
      end
      @rep.to_xml(@builder)
    end
      
  end
  
  context "Exceptions" do
    
    setup do
      @rep = Repetition.new
    end
    
    should "raise an exception if passed an invalid duration" do
      assert_raises ArgumentError do
        @rep.duration "dfdsdf"
      end
    end
    
    should "raise an exception if passed an invalid interval" do
      assert_raises ArgumentError do
        @rep.interval "dsfd"
      end
    end
    
  end
  
end