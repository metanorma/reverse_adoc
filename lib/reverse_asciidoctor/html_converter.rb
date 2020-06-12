# frozen_string_literal: true

require 'reverse_asciidoctor/converters/a'
require 'reverse_asciidoctor/converters/aside'
require 'reverse_asciidoctor/converters/audio'
require 'reverse_asciidoctor/converters/blockquote'
require 'reverse_asciidoctor/converters/br'
require 'reverse_asciidoctor/converters/bypass'
require 'reverse_asciidoctor/converters/code'
require 'reverse_asciidoctor/converters/div'
require 'reverse_asciidoctor/converters/drop'
require 'reverse_asciidoctor/converters/em'
require 'reverse_asciidoctor/converters/figure'
require 'reverse_asciidoctor/converters/h'
require 'reverse_asciidoctor/converters/head'
require 'reverse_asciidoctor/converters/hr'
require 'reverse_asciidoctor/converters/ignore'
require 'reverse_asciidoctor/converters/img'
require 'reverse_asciidoctor/converters/mark'
require 'reverse_asciidoctor/converters/li'
require 'reverse_asciidoctor/converters/ol'
require 'reverse_asciidoctor/converters/p'
require 'reverse_asciidoctor/converters/pass_through'
require 'reverse_asciidoctor/converters/pre'
require 'reverse_asciidoctor/converters/q'
require 'reverse_asciidoctor/converters/strong'
require 'reverse_asciidoctor/converters/sup'
require 'reverse_asciidoctor/converters/sub'
require 'reverse_asciidoctor/converters/table'
require 'reverse_asciidoctor/converters/td'
require 'reverse_asciidoctor/converters/th'
require 'reverse_asciidoctor/converters/text'
require 'reverse_asciidoctor/converters/tr'
require 'reverse_asciidoctor/converters/video'
require 'reverse_asciidoctor/converters/math'

module ReverseAsciidoctor
  class HtmlConverter
    def self.convert(input, options = {})
      root = if input.is_a?(String)
              then Nokogiri::HTML(input).root
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