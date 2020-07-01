# frozen_string_literal: true

require 'reverse_asciidoctor/converters/a'
require 'reverse_asciidoctor/converters/blockquote'
require 'reverse_asciidoctor/converters/bypass'
require 'reverse_asciidoctor/converters/br'
require 'reverse_asciidoctor/converters/code'
require 'reverse_asciidoctor/converters/def'
require 'reverse_asciidoctor/converters/definition'
require 'reverse_asciidoctor/converters/drop'
require 'reverse_asciidoctor/converters/em'
require 'reverse_asciidoctor/converters/example'
require 'reverse_asciidoctor/converters/head'
require 'reverse_asciidoctor/converters/hr'
require 'reverse_asciidoctor/converters/ignore'
require 'reverse_asciidoctor/converters/note'
require 'reverse_asciidoctor/converters/p'
require 'reverse_asciidoctor/converters/pass_through'
require 'reverse_asciidoctor/converters/q'
require 'reverse_asciidoctor/converters/strong'
require 'reverse_asciidoctor/converters/sup'
require 'reverse_asciidoctor/converters/sub'
require 'reverse_asciidoctor/converters/synonym'
require 'reverse_asciidoctor/converters/term'
require 'reverse_asciidoctor/converters/text'

module ReverseAsciidoctor
  class StepmodDefinitionConverter
    def self.convert(input, options = {})
      root = if input.is_a?(String)
                then Nokogiri::XML(input).root
              elsif input.is_a?(Nokogiri::XML::Document)
                then input.root
              elsif input.is_a?(Nokogiri::XML::Node)
                then input
              end

      root || (return '')

      ReverseAsciidoctor.config.with(options) do
        result = ReverseAsciidoctor::Converters.lookup(root.name).convert(root)
        ReverseAsciidoctor.cleaner.tidy(result)
      end
    end
  end
end
