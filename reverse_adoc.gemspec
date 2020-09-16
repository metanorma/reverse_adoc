# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "reverse_adoc/version"

Gem::Specification.new do |s|
  s.name        = "reverse_adoc"
  s.version     = ReverseAdoc::VERSION
  s.authors       = ["Ribose Inc."]
  s.email         = ["open.source@ribose.com"]

  s.homepage    = "http://github.com/metanorma/reverse_adoc"
  s.summary     = %q{Generate AsciiDoc from HTML and Microsoft Word via CLI or library.}
  s.description = %q{Generate AsciiDoc from HTML and Microsoft Word via CLI or library.}
  s.license       = "BSD-2-Clause"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # specify any dependencies here; for example:
  s.add_dependency 'nokogiri', ">= 1.10.4"
  s.add_dependency 'mathml2asciimath'
  s.add_dependency 'mimemagic'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'codeclimate-test-reporter'

  # spec.add_runtime_dependency "thor"

  # All the following are for bin/w2m
  s.add_dependency 'word-to-markdown'
  s.add_dependency 'premailer', '~> 1.11.0'
end
