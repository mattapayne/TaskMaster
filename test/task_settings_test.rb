require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class TaskSettingsTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    should "ensure that the outer element is Settings" do
      builder = mock()
      builder.expects(:Settings)
      settings = TaskSettings.new
      settings.to_xml(builder)
    end
    
  end
  
end