gem "rspec", "1.2.9"
require 'rubygems'
require 'spec'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'

autoload :RubyPoint, 'lib/rubypoint'

desc "Run dhem speccczzz"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec

GEM = 'rubypoint'
GEM_NAME = 'rubypoint'
GEM_VERSION = '0.0.1'
AUTHORS = ['James Pozdena']
EMAIL = "jpoz@jpoz.net"
HOMEPAGE = "http://github.com/jpoz/rubypoint"
SUMMARY = "Make pptx files with Ruby."
 
spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["GPL-LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.autorequire = GEM
  s.add_dependency('zipruby', '>= 0.3.2')
  s.add_dependency('hpricot', '>= 0.8.1')
  s.files = %w(GPL-LICENSE README.textile Rakefile) + Dir.glob("{lib}/**/*")
end
 
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
 
desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end
 
desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end


# RubyPoint specific

desc "Decompress a pptx into a folder in tmp/"
task :decompress, :file_path do |t, args|
  file_name = args.file_path.split('/').last
  puts "Decompressing #{args.file_path} into tmp/#{file_name}/"
  RubyPoint.open_doc(args.file_path, "tmp/#{file_name}")
end

desc "Recompress a folder into a pptx"
task :recompress, :folder_path, :save_path do |t, args|
  puts "Recompressing #{args.folder_path} into #{args.save_path}"
  RubyPoint.compress_folder(args.folder_path, args.save_path)
end

desc "Diff two pptxs"
task :diff, :file1, :file2 do |t, args|
  puts "Diff of #{args.file1} and #{args.file2}"
  results = RubyPoint.diff(args.file1, args.file2)
  results.each do |r|
    puts r[:path]
    r[:errors].each do |e|
      puts "    #{e}"
    end
  end
end

desc "show two pptxs files"
task :show, :file1, :file2, :path do |t, args|
  puts "Showing #{args.file1} and #{args.file2}"
  puts RubyPoint.show(args.file1, args.file2, args.path)
end



