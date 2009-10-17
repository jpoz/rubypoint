# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rubypoint}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["James Pozdena"]
  s.autorequire = %q{rubypoint}
  s.date = %q{2009-10-17}
  s.description = %q{Make pptx files with Ruby.}
  s.email = %q{jpoz@jpoz.net}
  s.extra_rdoc_files = ["GPL-LICENSE"]
  s.files = ["GPL-LICENSE", "README.textile", "Rakefile", "lib/rubypoint", "lib/rubypoint/content_types_xml.rb", "lib/rubypoint/core.rb", "lib/rubypoint/docProps", "lib/rubypoint/docProps/app.rb", "lib/rubypoint/element.rb", "lib/rubypoint/file.rb", "lib/rubypoint/ppt", "lib/rubypoint/ppt/presentation.rb", "lib/rubypoint/ppt/rels", "lib/rubypoint/ppt/rels/presentation_rel.rb", "lib/rubypoint/presentation.rb", "lib/rubypoint/relationship.rb", "lib/rubypoint/slide", "lib/rubypoint/slide/rel.rb", "lib/rubypoint/slide/slide.rb", "lib/rubypoint/textfield.rb", "lib/rubypoint.rb"]
  s.homepage = %q{http://github.com/jpoz/rubypoint}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Make pptx files with Ruby.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<zipruby>, [">= 0.3.2"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8.1"])
    else
      s.add_dependency(%q<zipruby>, [">= 0.3.2"])
      s.add_dependency(%q<hpricot>, [">= 0.8.1"])
    end
  else
    s.add_dependency(%q<zipruby>, [">= 0.3.2"])
    s.add_dependency(%q<hpricot>, [">= 0.8.1"])
  end
end
