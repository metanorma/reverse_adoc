module ReverseAdoc
  module Converters
    class Figure < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        "\n\n#{anchor}#{title}====\n" << treat_children(node, state).strip << "\n====\n\n"
      end

      def extract_title(node)
        title = node.at("./figcaption")
        return "" if title.nil?
        treat_children(title, {})
      end
    end

    register :figure, Figure.new
  end
end
