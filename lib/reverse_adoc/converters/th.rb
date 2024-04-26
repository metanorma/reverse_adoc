module ReverseAdoc
  module Converters
    class Th < Td
      def cellstyle(node)
        # this is the header row
        return "" if node.parent.previous_element.nil?

        "h"
      end
    end

    register :th, Th.new
  end
end
