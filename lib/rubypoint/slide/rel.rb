class RubyPoint::Slide::Rel < RubyPoint::File
  
  def initialize(slide)
    @parent = slide
    @presenation = slide.presentation
    @file_path = @presenation.slide_directory + "/_rels/slide#{@parent.slide_id}.xml.rels"
    @doc = Hpricot::XML(self.raw_xml)
  end
  
  def raw_xml
    raw = <<EOF 
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout2.xml"/></Relationships>
EOF
  end
end
