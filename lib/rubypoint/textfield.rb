class RubyPoint::TextField < RubyPoint::Element
  attr_accessor :text, :x, :y, :width, :height
  
  def initialize(text="",x=3200400, y=4572000, w=3200400, h=572000)
    @dirty = true
    @text = text
    @x, @y, @width, @height = x, y, w, h
  end
  
  def write
    @parent.doc.search('//p:spTree').append(self.raw)
  end
  
  def raw
    raw = <<EOF 
<p:sp><p:nvSpPr><p:cNvPr id="#{self.object_id}" name="TextBox #{self.object_id}"/><p:cNvSpPr txBox="1"/><p:nvPr/></p:nvSpPr><p:spPr><a:xfrm><a:off x="#{self.x}" y="#{self.y}"/><a:ext cx="#{self.width}" cy="#{self.height}"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom><a:noFill/></p:spPr><p:txBody><a:bodyPr wrap="square" rtlCol="0"><a:spAutoFit/></a:bodyPr><a:lstStyle/><a:p><a:r><a:rPr lang="en-US" dirty="0" smtClean="0"/><a:t>#{self.text}</a:t></a:r></a:p></p:txBody></p:sp>
EOF
  end
end
