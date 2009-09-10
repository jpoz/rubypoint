require File.dirname(__FILE__) + '/../../../spec_helper'

describe RubyPoint::PresentationRel do
  
  before(:each) do
    @rp = RubyPoint::Presentation.new('base.pptx')
    @p_rel = @rp.presentation_rel
  end

  it "should create a presentation relationship file when a presentation is created" do
    @p_rel.should_not be_nil
  end
  
  describe 'writing' do
    before(:each) do
      @rp.new_slide
      @p_rel.write
    end
    
    it "should write out a new relationship per slide" do
      doc = doc_from(@p_rel)
      doc.search("//Relationships/Relationship[@Target='slides/slide1.xml']").should_not be_empty
      doc.search("//Relationships/Relationship[@Target='slides/slide2.xml']").should_not be_empty
    end
  end
  
end
