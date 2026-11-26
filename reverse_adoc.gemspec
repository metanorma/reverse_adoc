# -*- encoding: utf-8 -*-

require_relative "lib/reverse_adoc/version"

Gem::Specification.new do |s|
  s.name        = "reverse_adoc"
  s.version     = ReverseAdoc::VERSION
  s.authors       = ["Ribose Inc."]
  s.email         = ["open.source@ribose.com"]

  s.homepage    = "http://github.com/metanorma/reverse_adoc"
  s.summary     = "Compatibility facade for ceradoc: generate AsciiDoc from HTML."
  s.description = "Compatibility facade for ceradoc: generate AsciiDoc from HTML. " \
                  "The former reverse_adoc converter lives in the ceradoc monorepo."
  s.license       = "BSD-2-Clause"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- exe/*`.split("\n").map do |f|
    File.basename(f)
  end
  s.bindir        = "exe"
  s.require_paths = ["lib"]
  # >= 3.3.0 is the floor every ceradoc gem carries (ceradoc hub,
  # ceradoc-adoc, ceradoc-html); the facade cannot resolve below it.
  s.required_ruby_version = Gem::Requirement.new(">= 3.3.0")

  # reverse_adoc is a facade: the HTML-to-AsciiDoc engine lives in the
  # ceradoc monorepo (renamed coradoc → coridoc → ceradoc, 2026-11-25).
  # The hub floors follow the metanorma-plugin-lutaml html2adoc precedent.
  s.add_dependency "ceradoc", "~> 3.0"
  s.add_dependency "ceradoc-adoc", "~> 2.0"
  s.add_dependency "ceradoc-html", "~> 1.1"
end
