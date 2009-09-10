require "rubygems"

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

class RubyPoint
  def self.working_directory
    'tmp/'
  end
  
  def self.open_doc(file_path, save_path=false)
    file_name = file_path.split('/').last
    save_path = file_name.split('.').first unless save_path
    tmp_file = "#{save_path}/#{file_name}"
    system("mkdir #{save_path}")
    system("cp #{file_path} #{tmp_file}")
    system("unzip -q #{tmp_file} -d #{save_path}/")
    system("rm #{tmp_file}")
  end
  
  def self.compress_folder(folder_path, file_path)
    Zip::Archive.open(file_path, Zip::CREATE) do |zip_file|
      Dir.glob("#{folder_path}/**/*", ::File::FNM_DOTMATCH).each do |path|
        zip_path = path.gsub("#{folder_path}/","")
        next if zip_path == "." || zip_path == ".." || zip_path.match(/DS_Store/)
        if ::File.directory?(path)
          zip_file.add_dir(zip_path)
        else
          zip_file.add_file(zip_path, path)
        end
      end
    end
  end
  
  def self.clear_working_directory
    system("rm -rf #{self.working_directory}*")
  end
end

require "rubypoint/core"
