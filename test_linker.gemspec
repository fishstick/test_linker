# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{test_linker}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve Loveless, Randy Stoller, Sujin Philip, Vikram Raina"]
  s.date = %q{2011-04-03}
  s.description = %q{This is a Ruby wrapper around the TestLink XMLRPC API, thus allowing access to your TestLink test projects, plans, cases, and results using Ruby.  We've added a few helper methods as well to allow for getting at more of your data a little easier.  This supports TestLink APIs 1.0 Beta 5 (from TestLink 1.8.x) and 1.0 (from TestLink 1.9.x).}
  s.email = ["steve.loveless@gmail.com"]
  s.extra_rdoc_files = [
    "ChangeLog.rdoc",
    "LICENSE.rdoc",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gemtest",
    ".rspec",
    ".yardopts",
    "ChangeLog.rdoc",
    "Gemfile",
    "LICENSE.rdoc",
    "README.rdoc",
    "Rakefile",
    "features/get_info.feature",
    "features/step_definitions/get_info_steps.rb",
    "features/support/common.rb",
    "features/support/env.rb",
    "gemspec.yml",
    "lib/test_linker.rb",
    "lib/test_linker/error.rb",
    "lib/test_linker/helpers.rb",
    "lib/test_linker/version.rb",
    "lib/test_linker/wrapper.rb",
    "spec/spec_helper.rb",
    "spec/test_linker_spec.rb",
    "test_linker.gemspec"
  ]
  s.homepage = %q{http://rubygems.org/gems/test_linker}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{test_linker}
  s.rubygems_version = %q{1.7.1}
  s.summary = %q{An interface to the TestLink XMLRPC API}
  s.test_files = [
    "spec/test_linker_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<versionomy>, ["~> 0.4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_runtime_dependency(%q<test_linker>, [">= 0"])
      s.add_runtime_dependency(%q<versionomy>, ["~> 0.4.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_development_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_development_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
    else
      s.add_dependency(%q<versionomy>, ["~> 0.4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<test_linker>, [">= 0"])
      s.add_dependency(%q<versionomy>, ["~> 0.4.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<ore>, ["~> 0.7.2"])
      s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
      s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<simplecov>, [">= 0.4.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
    end
  else
    s.add_dependency(%q<versionomy>, ["~> 0.4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<test_linker>, [">= 0"])
    s.add_dependency(%q<versionomy>, ["~> 0.4.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<ore>, ["~> 0.7.2"])
    s.add_dependency(%q<ore-core>, ["~> 0.1.4"])
    s.add_dependency(%q<ore-tasks>, ["~> 0.5.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<simplecov>, [">= 0.4.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
  end
end

