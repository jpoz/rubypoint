class RubyPoint::File < RubyPoint::Element
    
  attr_accessor :file_path, :doc
  
  def write
    self.before_write if self.respond_to?(:before_write)
    self.objects.each do |o|
      o.write
    end
    File.open(@file_path, "w") do |f|
      f.puts self.doc
    end
  end
  
  def <<(object)
    object.parent = self
    self.objects << object
  end
  
end