class RubyPoint::App < RubyPoint::File

  def initialize(presentation)
    @presentation = presentation
    @file_path = presentation.file_directory + "/docProps/app.xml"
  end
  
  def before_write
    self.slides.each do |s|
      self << Slide.new(s)
    end
  end
  
  def slides
    @presentation.slides
  end

  def doc
    @doc ||= Hpricot::XML(raw)
  end

  def raw
    raw = <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"><TotalTime>2</TotalTime><Words>8</Words><Application>Microsoft Macintosh PowerPoint</Application><PresentationFormat>On-screen Show (4:3)</PresentationFormat><Paragraphs>2</Paragraphs><Slides>#{self.slides.size}</Slides><Notes>0</Notes><HiddenSlides>0</HiddenSlides><MMClips>0</MMClips><ScaleCrop>false</ScaleCrop><HeadingPairs><vt:vector size="4" baseType="variant"><vt:variant><vt:lpstr>Design Template</vt:lpstr></vt:variant><vt:variant><vt:i4>1</vt:i4></vt:variant><vt:variant><vt:lpstr>Slide Titles</vt:lpstr></vt:variant><vt:variant><vt:i4>#{self.slides.size}</vt:i4></vt:variant></vt:vector></HeadingPairs><TitlesOfParts><vt:vector size="#{self.slides.size + 1}" baseType="lpstr"><vt:lpstr>Office Theme</vt:lpstr></vt:vector></TitlesOfParts><Company>Revelation</Company><LinksUpToDate>false</LinksUpToDate><SharedDoc>false</SharedDoc><HyperlinksChanged>false</HyperlinksChanged><AppVersion>12.0000</AppVersion></Properties>
EOF
  end
  
  class Slide < RubyPoint::Element
    
    attr_accessor :slide
    
    def initialize(slide)
      @slide = slide
    end
    
    def write
      # TODO need a freaking better search that this!!!
      @parent.doc.search("//vt:vector[@baseType='lpstr']").html += self.raw
    end
    
    def raw
      %Q{<vt:lpstr>Slide #{slide.slide_id}</vt:lpstr>}
    end
  end
  
end