module ReverseAsciidoctor
  module Converters
    class Td < Base
      def convert(node, state = {})
        id = node['id']
        colspan = node['colspan']
        rowspan = node['rowspan']
        colrowattr = colrow(colspan, rowspan)
        alignattr = alignstyle(node)
        anchor = id ? "[[#{id}]]" : ""
        style = cellstyle(node)
        content = treat_children(node, state)
        "#{colrowattr}#{alignattr}#{style}| #{anchor}#{content} "
      end

      def cellstyle(node)
        ""
      end

      def colrow(colspan, rowspan)
        if colspan && rowspan
          "#{colspan}.#{rowspan}+"
        elsif colspan
          "#{colspan}+"
        elsif rowspan
          ".#{rowspan}+"
        else
          ""
        end
      end

      def alignstyle(node)
        align = node["align"]
        valign = node["valign"]
        a = case align
              when "left" then "<"
              when "center" then "^"
              when "right" then ">"
            else
              ""
            end
        v = case valign
              when "top" then "<"
              when "middle" then "^"
              when "bottom" then ">"
            else
              ""
            end
        if align && valign
          "#{a}.#{v}"
        elsif align
          a
        elsif valign
          ".#{v}"
        else
          ""
        end
      end
    end

    register :td, Td.new
  end
end
