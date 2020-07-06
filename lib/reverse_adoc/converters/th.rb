module ReverseAdoc
  module Converters
    class Th < Td
      def cellstyle(node)
        if node.parent.previous_element.nil?
          # this is the header row
          ""
        else
          "h"
        end
      end
    end

    register :th, Th.new
  end
end
