require File.dirname(__FILE__) + '/../spec_helper'

describe RubyPoint::Presentation do
  it "should not raise an error when initializing a new presentation" do
    lambda {
      RubyPoint::Presentation.new('base.pptx')
    }.should_not raise_error
  end
  
  describe 'with a base file' do
    before(:each) do
      @rp = RubyPoint::Presentation.new('base.pptx')
    end
    
    it "should load the slides in the file" do
      @rp.slides.size.should == 1
      @rp.slides.all? { |s| s.is_a?(RubyPoint::Slide) }.should be_true
    end
  end
  
end
