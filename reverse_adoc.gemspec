# -*- encoding: utf-8 -*-

$:.push File.expand_path("lib", __dir__)
require "reverse_adoc/version"

Gem::Specification.new do |s|
  s.name        = "reverse_adoc"
  s.version     = ReverseAdoc::VERSION
  s.authors       = ["Ribose Inc."]
  s.email         = ["open.source@ribose.com"]

  s.homepage    = "http://github.com/metanorma/reverse_adoc"
  s.summary     = "Generate AsciiDoc from HTML and Microsoft Word via CLI or library."
  s.description = "Generate AsciiDoc from HTML and Microsoft Word via CLI or library."
  s.license       = "BSD-2-Clause"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- exe/*`.split("\n").map do |f|
    File.basename(f)
  end
  s.bindir        = "exe"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  # specify any dependencies here; for example:
  s.add_dependency "coradoc", "~> 0.2"
  s.add_dependency "marcel", "~> 1.0.0"
  s.add_dependency "mathml2asciimath"
  s.add_dependency "nokogiri", "~> 1.13"
  s.add_development_dependency "codeclimate-test-reporter"
  s.add_development_dependency "rake"
  s.add_development_dependency "redcarpet"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"

  # spec.add_runtime_dependency "thor"

  # All the following are for bin/w2m
  s.add_dependency "premailer", "~> 1.11.0"
  s.add_dependency "word-to-markdown"
end
