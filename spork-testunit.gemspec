# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spork-testunit}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tim Harper"]
  s.date = %q{2009-09-12}
  s.default_executable = %q{testdrb}
  s.description = %q{Test Unit runner for spork}
  s.email = ["timcharper+spork@gmail.com"]
  s.executables = ["testdrb"]
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "bin/testdrb",
     "lib/spork/test_framework/test_unit.rb"
  ]
  s.homepage = %q{http://github.com/timcharper/spork-testunit}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{spork-testunit}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{spork-testunit}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<spork>, [">= 0.6.0"])
    else
      s.add_dependency(%q<spork>, [">= 0.6.0"])
    end
  else
    s.add_dependency(%q<spork>, [">= 0.6.0"])
  end
end
