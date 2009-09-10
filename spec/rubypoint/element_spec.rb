require File.dirname(__FILE__) + '/../spec_helper'

describe RubyPoint::Element do
  
  describe 'class_attributes' do
    
    before(:each) do
      RubyPoint::Element.class_attributes(:awesome)
    end
    
    it "should create a method for each attribute to set the structure" do
      RubyPoint::Element.respond_to?(:awesome).should be_true
    end
    
    it "should be able to take multiple attributes" do
      RubyPoint::Element.class_attributes(:blarg, :ftang, :yaba)
      RubyPoint::Element.respond_to?(:blarg).should be_true
      RubyPoint::Element.respond_to?(:ftang).should be_true
      RubyPoint::Element.respond_to?(:yaba).should be_true
    end
    
    it "should evaluate the attribute for the instance if a block is given" do
      RubyPoint::Element.awesome { |e| "did you know that my parent is a #{e.parent.class}?" }
      r = RubyPoint::Element.new()
      r.parent = Hash.new
      r.awesome.should == 'did you know that my parent is a Hash?'
    end
    
    it "should give the value of the string given to it" do
      RubyPoint::Element.awesome "buttzzz"
      RubyPoint::Element.new().awesome.should == 'buttzzz'
    end
  end

end
