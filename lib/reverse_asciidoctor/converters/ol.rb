module ReverseAsciidoctor
  module Converters
    class Ol < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        ol_count = state.fetch(:ol_count, 0) + 1
        attrs = ol_attrs(node)
        "\n#{anchor}#{attrs}" << treat_children(node, state.merge(ol_count: ol_count))
      end

      def number_style(node)
        style = case node["style"]
                when "1" then "arabic"
                when "A" then "upperalpha"
                when "a" then "loweralpha"
                when "I" then "upperroman"
                when "i" then "lowerroman"
                else
                  nil
                end
      end

      def ol_attrs(node)
        style = number_style(node)
        reversed = "%reversed" if node["reversed"]
        start = "start=#{node['start']}" if node["start"]
        type = "type=#{node['type']}" if node["type"]
        attrs = []
        attrs << style if style
        attrs << reversed if reversed
        attrs << start if start
        attrs << type if type
        if attrs.empty?
          ""
        else
          "[#{attrs.join(',')}]\n"
        end
      end
    end

    register :ol, Ol.new
    register :ul, Ol.new
    register :dir, Ol.new
  end
end
