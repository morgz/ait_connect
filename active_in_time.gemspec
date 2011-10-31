# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ait_connect}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Morgan"]
  s.date = %q{2011-10-19}
  s.email = %q{danmorgz@gmail.com}
  s.files = [
    "README.md",
    "lib/active_in_time.rb",
    "lib/ait_connect.rb",
    "lib/active_in_time/base.rb",
    "lib/active_in_time/site.rb",
    "lib/active_in_time/site_proxy.rb",
    "spec/THERE_ARENT_ANY",
  ]
  s.homepage = %q{https://github.com/morgz/ait_connect}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Active In Time Ruby API wrapper}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
