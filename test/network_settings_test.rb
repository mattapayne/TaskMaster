require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class NetworkSettingsTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    should "ensure that the outer element is NetworkSettings" do
      builder = mock()
      builder.expects(:NetworkSettings)
      settings = NetworkSettings.new
      settings.to_xml(builder)
    end
    
  end
  
end