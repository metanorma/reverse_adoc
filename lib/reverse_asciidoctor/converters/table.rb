module ReverseAsciidoctor
  module Converters
    class Table < Base
      def convert(node, state = {})
        id = node['id']
        "\n\n" << treat_children(node, state) << "\n"
      end
    end

    register :table, Table.new
  end
end
