module ReverseAsciidoctor
  module Converters
    class Table < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        attrs = style(node)
        "\n\n#{anchor}#{attrs}#{title}|===\n" << treat_children(node, state) << "\n|===\n"
      end

      def extract_title(node)
        title = node.at("./caption")
        return "" if title.nil?
        treat_children(title, {})
      end

      def style(node)
        width = "width=#{node['width']}" if node['width']
        attrs = []
        attrs << width if width
        return "" if attrs.empty?
        "[#{attrs.join(',')}]\n"
      end
    end

    register :table, Table.new
  end
end
