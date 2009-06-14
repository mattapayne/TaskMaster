require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class IdleSettingsTest < Test::Unit::TestCase
  
  context "creating XML" do
    
    setup do
      @settings = IdleSettings.new
      @builder = mock()
    end
    
    should "create an IdleSettings element" do
      @builder.expects(:IdleSettings)
      @settings.to_xml(@builder)
    end
    
    should "create a WaitTimeout element if wait_timeout is set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:WaitTimeout)
      end
      @settings.wait_timeout 1.day
      @settings.to_xml(@builder)
    end
    
    should "NOT create a WaitTimeout element if wait_timeout is NOT set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:WaitTimeout).never
      end
      @settings.to_xml(@builder)
    end
    
    should "create a Duration element if duration is set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:Duration)
      end
      @settings.duration 1.day
      @settings.to_xml(@builder)
    end
    
    should "NOT create a Duration element if duration is NOT set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:Duration).never
      end
      @settings.to_xml(@builder)
    end
    
    should "create a TerminateOnIdleEnd element if terminate_on_idle_end is set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:TerminateOnIdleEnd)
      end
      @settings.terminate_on_idle_end true
      @settings.to_xml(@builder)
    end
    
    should "NOT create a TerminateOnIdleEnd element if terminate_on_idle_end is NOT set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:TerminateOnIdleEnd).never
      end
      @settings.to_xml(@builder)
    end
    
    should "create a RestartOnIdle element if restart_on_idle is set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:RestartOnIdle)
      end
      @settings.restart_on_idle true
      @settings.to_xml(@builder)
    end
    
    should "NOT create a RestartOnIdle element if restart_on_idle is NOT set" do
      @builder.stubs(:IdleSettings) do
        @builder.expects(:RestartOnIdle).never
      end
      @settings.to_xml(@builder)
    end
    
  end
  
  context "Exceptions" do
    
    setup do
      @settings = IdleSettings.new
    end
    
    should "throw an exception if duration is not valid" do
      assert_raises ArgumentError do
        @settings.duration "dfs"
      end
    end
    
    should "throw an exception if wait_timeout is not valid" do
      assert_raises ArgumentError do
        @settings.wait_timeout "dsfdf"
      end
    end
    
  end
  
end