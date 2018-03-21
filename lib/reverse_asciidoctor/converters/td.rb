module ReverseAsciidoctor
  module Converters
    class Td < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]" : ""
        content = treat_children(node, state)
        "| #{anchor}#{content} "
      end
    end

    register :td, Td.new
    register :th, Td.new
  end
end
