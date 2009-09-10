gem "rspec", "1.2.6"
require 'spec'
require 'spec/rake/spectask'

desc "Run dhem speccczzz"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "\"#{File.dirname(__FILE__)}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :default => :spec