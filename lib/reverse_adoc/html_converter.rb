# frozen_string_literal: true

require_relative "converters/a"
require_relative "converters/aside"
require_relative "converters/audio"
require_relative "converters/blockquote"
require_relative "converters/br"
require_relative "converters/bypass"
require_relative "converters/code"
require_relative "converters/div"
require_relative "converters/drop"
require_relative "converters/em"
require_relative "converters/figure"
require_relative "converters/h"
require_relative "converters/head"
require_relative "converters/hr"
require_relative "converters/ignore"
require_relative "converters/img"
require_relative "converters/mark"
require_relative "converters/li"
require_relative "converters/ol"
require_relative "converters/p"
require_relative "converters/pass_through"
require_relative "converters/pre"
require_relative "converters/q"
require_relative "converters/strong"
require_relative "converters/sup"
require_relative "converters/sub"
require_relative "converters/table"
require_relative "converters/td"
require_relative "converters/th"
require_relative "converters/text"
require_relative "converters/tr"
require_relative "converters/video"
require_relative "converters/math"

module ReverseAdoc
  class HtmlConverter
    def self.to_coradoc(input, options = {})
      root = case input
             when String
               Nokogiri::HTML(input).root
             when Nokogiri::XML::Document
               input.root
             when Nokogiri::XML::Node
               input
             end

      return "" unless root

      ReverseAdoc.config.with(options) do
        ReverseAdoc::Converters.lookup(root.name).to_coradoc(root)
      end
    end

    def self.convert(input, options = {})
      result = Coradoc::Generator.gen_adoc(to_coradoc(input, options))
      ReverseAdoc.cleaner.tidy(result)
    end
  end
end
