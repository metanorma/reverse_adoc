# frozen_string_literal: true

require "reverse_adoc/converters/a"
require "reverse_adoc/converters/aside"
require "reverse_adoc/converters/audio"
require "reverse_adoc/converters/blockquote"
require "reverse_adoc/converters/br"
require "reverse_adoc/converters/bypass"
require "reverse_adoc/converters/code"
require "reverse_adoc/converters/div"
require "reverse_adoc/converters/drop"
require "reverse_adoc/converters/em"
require "reverse_adoc/converters/figure"
require "reverse_adoc/converters/h"
require "reverse_adoc/converters/head"
require "reverse_adoc/converters/hr"
require "reverse_adoc/converters/ignore"
require "reverse_adoc/converters/img"
require "reverse_adoc/converters/mark"
require "reverse_adoc/converters/li"
require "reverse_adoc/converters/ol"
require "reverse_adoc/converters/p"
require "reverse_adoc/converters/pass_through"
require "reverse_adoc/converters/pre"
require "reverse_adoc/converters/q"
require "reverse_adoc/converters/strong"
require "reverse_adoc/converters/sup"
require "reverse_adoc/converters/sub"
require "reverse_adoc/converters/table"
require "reverse_adoc/converters/td"
require "reverse_adoc/converters/th"
require "reverse_adoc/converters/text"
require "reverse_adoc/converters/tr"
require "reverse_adoc/converters/video"
require "reverse_adoc/converters/math"

module ReverseAdoc
  class HtmlConverter
    def self.convert(input, options = {})
      root = if input.is_a?(String)
              then Nokogiri::HTML(input).root
             elsif input.is_a?(Nokogiri::XML::Document)
              then input.root
             elsif input.is_a?(Nokogiri::XML::Node)
              then input
             end

      root || (return "")

      ReverseAdoc.config.with(options) do
        result = ReverseAdoc::Converters.lookup(root.name).convert(root)
        ReverseAdoc.cleaner.tidy(result)
      end
    end
  end
end
