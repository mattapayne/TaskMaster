require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class BaseSettingsTest < Test::Unit::TestCase
  
  context "Possible errors" do
    
    setup do
      @bs = BaseSettings.new
    end
    
    should "raise an exception if given a bad priority value" do
      assert_raises ArgumentError do
        @bs.priority 43
      end
      assert_raises ArgumentError do
        @bs.priority "test"
      end
      assert_raises ArgumentError do
        @bs.priority nil
      end
    end
    
    should "raise an exception if given a bad multiple instance value" do
      assert_raises ArgumentError do
        @bs.multiple_instances_policy 43
      end
      assert_raises ArgumentError do
        @bs.multiple_instances_policy "test"
      end
      assert_raises ArgumentError do
        @bs.multiple_instances_policy nil
      end
    end
    
  end
  
end