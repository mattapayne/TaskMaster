require File.expand_path(File.join(File.dirname(__FILE__), "..", "test_helper"))

class ComActionTest < Test::Unit::TestCase
  
  context "Creating XML" do
    
    setup do
      @builder = mock()
      @action = ComAction.new
    end
    
    should "create a ComHandler element" do
      @builder.expects(:ComHandler)
      @action.class_id "3F2504E0-4F89-11D3-9A0C-0305E82C3301"
      @action.to_xml(@builder)
    end
    
    should "create a ClassId element if classid is present" do
      @builder.stubs(:ComHandler) do
        expects(:ClassId)
      end
      @action.class_id "3F2504E0-4F89-11D3-9A0C-0305E82C3301"
      @action.to_xml(@builder)
    end
    
    should "create a Data element if data is present" do
      @builder.stubs(:ComHandler) do
        stubs(:ClassId)
        expects(:Data)
      end
      @action.data "Some Data"
      @action.class_id "3F2504E0-4F89-11D3-9A0C-0305E82C3301"
      @action.to_xml(@builder)
    end
    
    should "not create a Data element is data is not present" do
       @builder.stubs(:ComHandler) do
          stubs(:ClassId)
          expects(:Data).never
        end
        @action.class_id "3F2504E0-4F89-11D3-9A0C-0305E82C3301"
        @action.to_xml(@builder)
    end
    
    should "not create a ClassId element is classid is not present" do
       @builder.stubs(:ComHandler) do
          expects(:ClassId).never
        end
        @action.to_xml(@builder)
    end
    
  end
  
  context "Validity" do
    
    setup do
      @action = ComAction.new
    end
    
    should "not be valid if the classid is nil" do
      @action.class_id nil
      assert(!@action.valid?)
    end
    
    should "not be valid if the classid is empty" do
      @action.class_id ""
      assert(!@action.valid?)
    end
    
    should "not be valid if the classid is not a guid" do
      @action.class_id "sdffsff"
      assert(!@action.valid?)
    end
    
    should "be valid if the classid is non-nil and a guid" do
      @action.class_id "3F2504E0-4F89-11D3-9A0C-0305E82C3301"
      assert(@action.valid?)
    end
    
    should "have an error message if not valid" do
      @action.class_id nil
      assert(@action.errors.size == 1)
    end
       
  end
  
end