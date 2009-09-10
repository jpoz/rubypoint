class RubyPoint::Relationship < RubyPoint::Element
  
  attr_accessor :rel_id, :object
  class_attributes :target, :type
    
  def initialize(parent, object=false)
    @parent = parent
    @rel_id = parent.next_rel_id
    if object
      @object = object
      @object.rel_id = @rel_id
    end
  end
  
  def write
    @parent.doc.search('//Relationships').append(self.raw)
  end
  
  def raw
  raw = <<EOF 
<Relationship Id="rId#{self.rel_id}" Type="#{self.type}" Target="#{self.target}"/>
EOF
  end
  
end