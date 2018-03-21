module ReverseAsciidoctor
  module Converters
    class Td < Base
      def convert(node, state = {})
        id = node['id']
                anchor = id ? "[[#{id}]]\n" : ""
        content = treat_children(node, state)
        " #{content} |"
      end
    end

    register :td, Td.new
    register :th, Td.new
  end
end
