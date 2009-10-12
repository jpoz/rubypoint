class RubyPoint::PresentationRel < RubyPoint::File
      
  def initialize(presentation)
    @presentation = presentation
    @file_path = presentation.file_directory + "/ppt/_rels/presentation.xml.rels"
    @rel_id = 1
  end
  
  def before_write
    self.objects << RubyPoint::PresentationRel::PrinterSettings.new(self)
    self.objects << RubyPoint::PresentationRel::PresProps.new(self)
    self.objects << RubyPoint::PresentationRel::ViewProps.new(self)
    self.objects << RubyPoint::PresentationRel::Theme.new(self)
    self.objects << RubyPoint::PresentationRel::TableStyles.new(self)
  end
  
  def next_rel_id
    @rel_id += 1
  end
  
  def add_relationship_for(object)
    slide_rel = RubyPoint::PresentationRel::Slide.new(self, object)
    self.objects << slide_rel
    slide_rel
  end
  
  def doc
    @doc ||= Hpricot::XML(raw)
  end
  
  def raw
    raw = <<EOF
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/></Relationships>
EOF
  end
    
end

class RubyPoint::PresentationRel::Slide < RubyPoint::Relationship
  target { |s| "slides/slide#{s.object.slide_id}.xml" } # s is the instance of the RubyPoint::PresentationRel::Slide
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide"
end

class RubyPoint::PresentationRel::PresProps < RubyPoint::Relationship
  target "presProps.xml"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/presProps"
end

class RubyPoint::PresentationRel::ViewProps < RubyPoint::Relationship
  target "viewProps.xml"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/viewProps"
end

class RubyPoint::PresentationRel::SlideMaster < RubyPoint::Relationship
  target "slideMasters/slideMaster1.xml"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster"
end

class RubyPoint::PresentationRel::TableStyles < RubyPoint::Relationship
  target "tableStyles.xml"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/tableStyles"
end

class RubyPoint::PresentationRel::PrinterSettings < RubyPoint::Relationship
  target "printerSettings/printerSettings1.bin"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/printerSettings"
end

class RubyPoint::PresentationRel::Theme < RubyPoint::Relationship
  target "theme/theme1.xml"
  type   "http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme"
end
