require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyPoint::App do

  
  before(:each) do
    @presentation = RubyPoint::Presentation.new('base.pptx')
    @app = RubyPoint::App.new(@presentation)
  end
  
  describe "#before_write" do
    before(:each) do
      @app.before_write
    end
    
    it "should add each slide to it's objects" do
      @app.objects.size.should == @presentation.slides.size
    end
  end
  
  describe '#write' do
    it "should add a vt:lpstr to the vector for lpstr elements" do
      @app.write
      @app.doc.search("//vt:vector[@baseType='lpstr']").html.should == '<vt:lpstr>Office Theme</vt:lpstr><vt:lpstr>Slide 1</vt:lpstr>'
    end
  end
end
