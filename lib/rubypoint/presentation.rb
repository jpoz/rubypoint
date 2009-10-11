require 'zipruby'

class RubyPoint
  class Presentation
    
    attr_accessor :files, :slides
  
    def initialize(file_path)
      @working_directory = RubyPoint.working_directory
      @uuid = Time.now.to_i
      @files = []
      self.open(file_path)
    end
  
    def open(path)
      system("mkdir #{file_directory}")
      system("cp #{path} #{@working_directory}#{@uuid}/#{path}")
      system("unzip -q #{@working_directory}#{@uuid}/#{path} -d #{@working_directory}#{@uuid}/")
      system("rm #{@working_directory}#{@uuid}/#{path}")
      @files = Dir.glob("#{@working_directory}#{@uuid}/**/*", ::File::FNM_DOTMATCH)
    end
  
    def save(file_path, force=false)
      slides.each do |s|
        s.write
      end
      presentation_rel.write
      presentation_xml.write
      if ::File.exist?(file_path)
        force ? system("rm -f #{file_path}") : raise("#{file_path} already exists")
      end
      RubyPoint.compress_folder(file_directory, file_path)
    end
  
    def clean_file_directory
      system("rm -r #{file_directory}")
    end
    
    ### PRESENTATION PARTS
  
    def slides
      return @slides if @slides
      @slides = []
      slide_files = Dir.glob("#{file_directory}/ppt/slides/*.xml")
      slide_files.each do |f|
        @slides << RubyPoint::Slide.new(self, f)
      end
      @slides
    end
    
    def presentation_rel
      @presentation_rel ||= RubyPoint::PresentationRel.new(self)
    end
    
    def presentation_xml
      @presentation_xml ||= RubyPoint::Presentation::Presentation.new(self)
    end
    
  
    def new_slide
      RubyPoint::Slide.new(self)
    end
  
    def next_slide_id
      self.slides.size + 1
    end
    
    def add_to_relationships(object)
      self.presentation_rel.add_relationship_for(object)
    end
    
    def slide_directory
      file_directory + '/ppt/slides'
    end
  
    def file_directory
      "#{@working_directory}#{@uuid}"
    end
  end
end