module ReverseAdoc
  module Converters
    class Tr < Base
      def to_coradoc(node, state = {})
        content = treat_children_coradoc(node, state)
        header = table_header_row?(node)
        Coradoc::Element::Table::Row.new(content, header)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def table_header_row?(node)
        # node.element_children.all? {|child| child.name.to_sym == :th}
        node.previous_element.nil?
      end
    end

    register :tr, Tr.new
  end
end
