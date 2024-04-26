module ReverseAdoc
  module Converters
    class Td < Base
      def to_coradoc(node, state = {})
        # convert(node, state)
        id = node["id"]
        colrowattr = colrow(node["colspan"], node["rowspan"])
        alignattr = alignstyle(node)
        style = cellstyle(node)

        singlepara = node.elements.size == 1 && node.elements.first.name == "p"
        state[:tdsinglepara] = singlepara if singlepara

        adoccell = node.at(".//ul | .//ol | .//pre | .//blockquote | .//br | .//hr") ||
          node.at(".//p") && !singlepara

        style = "a" if adoccell
        delim = adoccell ? "\n" : " "
        content = treat_children_coradoc(node, state)
        options = {}.tap do |hash|
          hash[:id] = id
          hash[:colrowattr] = colrowattr
          hash[:alignattr] = alignattr
          hash[:style] = style
          hash[:content] = content
          hash[:delim] = delim
        end

        Coradoc::Element::Table::Cell.new(options)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def cellstyle(_node)
        ""
      end

      def colrow(colspan, rowspan)
        if colspan && rowspan && colspan != "1" && rowspan != "1"
          "#{colspan}.#{rowspan}+"
        elsif colspan && colspan != "1"
          "#{colspan}+"
        elsif rowspan && rowspan != "1"
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
