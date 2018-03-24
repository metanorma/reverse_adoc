# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "reverse_asciidoctor/version"

Gem::Specification.new do |s|
  s.name        = "reverse_asciidoctor"
  s.version     = ReverseAsciidoctor::VERSION
  s.authors       = ["Ribose Inc."]
  s.email         = ["open.source@ribose.com"]

  s.homepage    = "http://github.com/ribose/reverse_asciidoctor"
  s.summary     = %q{Convert html code into asciidoctor.}
  s.description = %q{Map simple html back into asciidoctor, e.g. if you want to import existing html data in your application.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'codeclimate-test-reporter'

  # All the following are for bin/w2m
  s.add_dependency 'word-to-markdown'
end
