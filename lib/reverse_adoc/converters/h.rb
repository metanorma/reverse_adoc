module ReverseAdoc
  module Converters
    class H < Base
      def to_coradoc(node, state = {})
        id = node["id"]
        internal_anchor = treat_children_anchors(node, state)

        if id.to_s.empty? && internal_anchor.size.positive?
          id = internal_anchor.first.id
        end

        level = node.name[/\d/].to_i
        content = treat_children_no_anchors(node, state)

        Coradoc::Element::Title.new(content, level, id: id)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def treat_children_no_anchors(node, state)
        node.children.reject { |a| a.name == "a" }.inject([]) do |memo, child|
          memo << treat_coradoc(child, state)
        end
      end

      def treat_children_anchors(node, state)
        node.children.select { |a| a.name == "a" }.inject([]) do |memo, child|
          memo << treat_coradoc(child, state)
        end
      end
    end

    register :h1, H.new
    register :h2, H.new
    register :h3, H.new
    register :h4, H.new
    register :h5, H.new
    register :h6, H.new
  end
end
