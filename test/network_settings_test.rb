require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class NetworkSettingsTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    setup do
      @builder = mock()
      @settings = NetworkSettings.new
    end
    
    should "ensure that the outer element is NetworkSettings" do
      @builder.expects(:NetworkSettings)
      @settings.to_xml(@builder)
    end
    
    should "create an Id element if id is set" do
      @builder.stubs(:NetworkSettings) do
        @builder.expects(:Id)
      end
      @settings.id 10
      @settings.to_xml(@builder)
    end
    
    should "create a Name element if name is set" do
      @builder.stubs(:NetworkSettings) do
        @builder.expects(:Name)
      end
      @settings.name "settings"
      @settings.to_xml(@builder)
    end
    
    should "NOT create an Id element if id is NOT set" do
      @builder.stubs(:NetworkSettings) do
        @builder.expects(:Id).never
      end
      @settings.to_xml(@builder)
    end
    
    should "NOT create a Name element if name is NOT set" do
      @builder.stubs(:NetworkSettings) do
        @builder.expects(:Name).never
      end
      @settings.to_xml(@builder)
    end
    
  end
  
end