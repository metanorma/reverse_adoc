module ReverseAsciidoctor
  module Converters
    class Td < Base
      def convert(node, state = {})
        id = node['id']
        colspan = node['colspan']
        rowspan = node['rowspan']
        colattr = colspan ? "#{colspan}+" : ""
        rowattr = rowspan ? ".#{rowspan}+" : ""
        anchor = id ? "[[#{id}]]" : ""
        style = cellstyle(node)
        content = treat_children(node, state)
        "#{colattr}#{rowattr}#{style}| #{anchor}#{content} "
      end

      def cellstyle(node)
        ""
      end
    end

    register :td, Td.new
  end
end
