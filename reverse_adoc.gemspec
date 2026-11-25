# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "reverse_adoc"
  s.version     = "2.0.0"
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

  # reverse_adoc is a codeless facade: the HTML/Word-to-AsciiDoc engine
  # lives in the ceradoc monorepo (renamed coradoc → coridoc → ceradoc,
  # 2026-11-25); the ceradoc hub carries the CoreModel and the
  # html→asciidoc pipeline.
  s.add_dependency "ceradoc", "~> 3.0"
end
