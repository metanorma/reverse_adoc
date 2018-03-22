module ReverseAsciidoctor
  module Converters
    class Ol < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        ol_count = state.fetch(:ol_count, 0) + 1
        style = number_style(node)
        "\n#{anchor}#{style}" << treat_children(node, state.merge(ol_count: ol_count))
      end

      def number_style(node)
        return "[arabic]\n" if node["style"] == "1"
        return "[upperalpha]\n" if node["style"] == "A"
        return "[loweralpha]\n" if node["style"] == "a"
        return "[upperroman]\n" if node["style"] == "I"
        return "[lowerroman]\n" if node["style"] == "i"
        ""
      end
    end

    register :ol, Ol.new
    register :ul, Ol.new
    register :dir, Ol.new
  end
end
