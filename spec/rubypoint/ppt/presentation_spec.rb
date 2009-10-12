require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyPoint::Presentation::Presentation do
  
  before(:each) do
    @presentation = RubyPoint::Presentation.new('base.pptx')
    @presentation_prez = RubyPoint::Presentation::Presentation.new(@presentation)
  end
  
  describe "#before_write" do
    before(:each) do
      @presentation_prez.before_write
    end
    
    it "should add each slide to it's objects" do
      @presentation_prez.objects.size.should == @presentation.slides.size
    end
  end
  
  describe '#write' do
    it "should add all the slides to the doc" do
      slide = @presentation.slides.first  
      slide_rel = @presentation_prez.objects.first
      @presentation_prez.write
      @presentation_prez.doc.search('//p:sldIdLst').innerHTML.should include(%Q{<p:sldId id="#{255+slide.slide_id}" r:id="rId#{slide.rel_id.rel_id}" />})
    end
  end

end
