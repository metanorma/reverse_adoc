# frozen_string_literal: true

require 'reverse_adoc/converters/a'
require 'reverse_adoc/converters/blockquote'
require 'reverse_adoc/converters/bypass'
require 'reverse_adoc/converters/br'
require 'reverse_adoc/converters/code'
require 'reverse_adoc/converters/drop'
require 'reverse_adoc/converters/em'
require 'reverse_adoc/converters/example'
require 'reverse_adoc/converters/ext_descriptions'
require 'reverse_adoc/converters/ext_description'
require 'reverse_adoc/converters/express_ref'
require 'reverse_adoc/converters/head'
require 'reverse_adoc/converters/hr'
require 'reverse_adoc/converters/ignore'
require 'reverse_adoc/converters/note'
require 'reverse_adoc/converters/p'
require 'reverse_adoc/converters/pass_through'
require 'reverse_adoc/converters/q'
require 'reverse_adoc/converters/strong'
require 'reverse_adoc/converters/sup'
require 'reverse_adoc/converters/sub'
require 'reverse_adoc/converters/text'

module ReverseAdoc
  class SmrlDescriptionConverter
    def self.convert(input, options = {})
      root = if input.is_a?(String)
                then Nokogiri::XML(input).root
              elsif input.is_a?(Nokogiri::XML::Document)
                then input.root
              elsif input.is_a?(Nokogiri::XML::Node)
                then input
              end

      root || (return '')

      ReverseAdoc.config.with(options) do
        result = ReverseAdoc::Converters.lookup(root.name).convert(root)
        ReverseAdoc.cleaner.tidy(result)
      end
    end
  end
end