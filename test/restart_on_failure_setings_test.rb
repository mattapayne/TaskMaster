require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class RestartOnFailureSettingsTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    setup do
      @builder = mock()
      @settings = RestartOnFailureSettings.new
    end
    
    should "create a RestartOnFailure element" do
      @builder.expects(:RestartOnFailure)
      @settings.to_xml(@builder)
    end
    
    should "create a Count element if count is set" do
      @builder.stubs(:RestartOnFailure) do
        @builder.expects(:Count)
      end
      @settings.count 10
      @settings.to_xml(@builder)
    end
    
    should "create an Interval element if interval is set" do
      @builder.stubs(:RestartOnFailure) do
        @builder.expects(:Interval)
      end
      @settings.interval 1.day
      @settings.to_xml(@builder)
    end
    
    should "NOT create a Count element if count is NOT set" do
      @builder.stubs(:RestartOnFailure) do
        @builder.expects(:Count).never
      end
      @settings.to_xml(@builder)
    end
    
    should "NOT create an Interval element if interval is NOT set" do
      @builder.stubs(:RestartOnFailure) do
        @builder.expects(:Interval).never
      end
      @settings.to_xml(@builder)
    end
    
  end
  
  context "Exceptions" do
    
    setup do
      @settings = RestartOnFailureSettings.new
    end
    
    should "raise an exception if interval is not valid" do
      assert_raises ArgumentError do
        @settings.interval "ffsddf"
      end
    end
    
  end
  
end