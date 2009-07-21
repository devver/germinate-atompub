# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{germinate-atompub}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Avdi Grimm"]
  s.date = %q{2009-07-21}
  s.default_executable = %q{germinate-atompub}
  s.description = %q{An Atom Publishing Protocol (APP) plugin for Germinate.}
  s.email = %q{avdi@avdi.org}
  s.executables = ["germinate-atompub"]
  s.extra_rdoc_files = ["History.txt", "README.txt", "bin/germinate-atompub", "lib/text.yml"]
  s.files = ["History.txt", "README.txt", "Rakefile", "bin/germinate-atompub", "examples/hello.rb", "lib/germinate-atompub.rb", "lib/germinate-atompub/atompub_publisher.rb", "lib/germinate_plugin_v0_init.rb", "lib/text.yml", "spec/germinate-atompub/atompub_publisher_spec.rb", "spec/germinate-atompub_spec.rb", "spec/spec_helper.rb", "test/test_germinate-atompub.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/devver/germinate-wordpress}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{germinate-app}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{An Atom Publishing Protocol (APP) plugin for Germinate}
  s.test_files = ["test/test_germinate-atompub.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bones>, [">= 2.5.1"])
    else
      s.add_dependency(%q<bones>, [">= 2.5.1"])
    end
  else
    s.add_dependency(%q<bones>, [">= 2.5.1"])
  end
end
