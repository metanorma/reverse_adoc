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
        start = "start=#{node['start']}" if node["start"]
        if style && start
          "[#{style},#{start}]\n"
        elsif style
          "[#{style}]\n"
        elsif start
          "[#{start}]\n"
        else
          ""
        end
      end
    end

    register :ol, Ol.new
    register :ul, Ol.new
    register :dir, Ol.new
  end
end
