# frozen_string_literal: true

require "ceradoc"
require "ceradoc/html"
require "ceradoc/asciidoc"

# DEPRECATED: reverse_adoc is retired. The HTML-to-AsciiDoc engine lives
# in the ceradoc monorepo — depend on ceradoc and call Ceradoc.convert
# directly. This shim emits a deprecation warning on load and will be
# removed; the gem is archived.
#
# Since 2.0.0 reverse_adoc ships no converter code of its own: the
# HTML-to-AsciiDoc engine moved into coradoc and now lives in the ceradoc
# monorepo as ceradoc-html (coradoc → coridoc → ceradoc, 2026-11-25).
# Requiring "reverse_adoc" loads that engine and delegates to its unified
# API, so downstream `require "reverse_adoc"` calls keep working.
warn "reverse_adoc is DEPRECATED and retired: use ceradoc " \
       "(Ceradoc.convert(input, from: :html, to: :asciidoc)) instead. " \
       "The reverse_adoc gem will not be maintained further."

module ReverseAdoc
  # Convert HTML to AsciiDoc.
  #
  # Legacy options are accepted for arity compatibility and ignored: the
  # tuning knobs moved into the ceradoc pipeline (see Ceradoc.convert).
  def self.convert(input, *_options)
    Ceradoc.convert(input, from: :html, to: :asciidoc)
  end
end
