gem "rspec", "1.2.9"
require 'rubygems'
require 'spec'
require 'spec/rake/spectask'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'

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
  s.extra_rdoc_files = ["MIT-LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.autorequire = GEM
  s.add_dependency('zipruby', '>= 0.3.2')
  s.files = %w(MIT-LICENSE README.textile Rakefile) + Dir.glob("{lib}/**/*")
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