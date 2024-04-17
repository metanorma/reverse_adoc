module ReverseAdoc
  module Converters
    class Figure < Base
      def to_coradoc(node, state = {})
        id = node['id']
        title = extract_title(node)
        content = treat_children(node, state).strip
        Coradoc::Document::Block.new(title, lines: content.lines, type: :example, id: id)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
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
