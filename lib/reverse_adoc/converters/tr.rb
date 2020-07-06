module ReverseAdoc
  module Converters
    class Tr < Base
      def convert(node, state = {})
        content = treat_children(node, state).rstrip
        result  = "#{content}\n"
        table_header_row?(node) ? result + underline_for(node) : result
      end

      def table_header_row?(node)
        # node.element_children.all? {|child| child.name.to_sym == :th}
        node.previous_element.nil?
      end

      def underline_for(node)
        "\n"
      end
    end

    register :tr, Tr.new
  end
end
