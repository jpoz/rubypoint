require "rubygems"
require 'ftools'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

class RubyPoint
  def self.working_directory
    'tmp/'
  end
  
  def self.open_doc(file_path, save_path)
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
  
  def self.diff(doc1, doc2)
    doc_id = Time.now.to_i
    open_doc(doc1, "tmp/TEST#{doc_id}_1")
    open_doc(doc2, "tmp/BASE#{doc_id}_2")
    `mate tmp/TEST#{doc_id}_1`
    `mate tmp/BASE#{doc_id}_2`
  end
  
  def self.show(doc1, doc2, path)
    require 'xmlsimple'
    doc_id = Time.now.to_i
    open_doc(doc1, "tmp/#{doc_id}_1")
    open_doc(doc2, "tmp/#{doc_id}_2")
    puts "tmp/#{doc_id}_1/#{path}"
    return Dir.glob("tmp/#{doc_id}_1/**/*", ::File::FNM_DOTMATCH).inspect unless ::File.exists?("tmp/#{doc_id}_1/#{path}") && ::File.exists?("tmp/#{doc_id}_2/#{path}")
    file1 = `xmllint --format tmp/#{doc_id}_1/#{path}`
    file2 = `xmllint --format tmp/#{doc_id}_2/#{path}`
    sizes_array = []
    file1_array = []
    file2_array = []
    file1.each_line { |line| file1_array << line }
    file2.each_line { |line| file2_array << line}
    max = 200
    results = ""
    file1_array.each_with_index do |line,i|
      disp = line
      disp += file2_array[i]
      results += disp
    end
    results
  end
  
  private
  
  def self.diff_unpacked(folder_path1, folder_path2)
    results = []
    Dir.glob("#{folder_path1}/**/*", ::File::FNM_DOTMATCH).each do |path|
      path2 = path.gsub(folder_path1,folder_path2)
      result = {:path => path, :path2 => path2, :errors => []}
      result[:errors] << 'File Does Not exist' unless ::File.exists?(path2)
      next unless ::File.file?(path) && ::File.file?(path2)
      file_diff = diff_files(path, path2)
      result[:errors] << file_diff unless file_diff.nil?
      result[:errors].flatten!
      results << result unless result[:errors].empty?
    end
    results
  end

  def self.diff_files(path1, path2)
    require 'xmlsimple'
    filename1 = path1.split('/').last
    file_type = path1.split('.').last
    return nil unless %w{xml rels}.include?(file_type)
    file1 = ::File.read(path1)
    file2 = ::File.read(path2)
    return nil if file1 == file2
    begin
      doc1 = y(XmlSimple.xml_in(file1))
      doc2 = y(XmlSimple.xml_in(file2))
    rescue
      return "Error reading doc"
    end
    "#{doc1} \n #{doc2}"
  end
  
end

require "rubypoint/core"
