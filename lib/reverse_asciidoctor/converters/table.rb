module ReverseAsciidoctor
  module Converters
    class Table < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        "\n\n#{anchor}#{title}|===\n" << treat_children(node, state) << "\n|===\n"
      end

      def extract_title(node)
        title = node.at("./caption")
        return "" if title.nil?
        treat_children(title, {})
      end
    end

    register :table, Table.new
  end
end
