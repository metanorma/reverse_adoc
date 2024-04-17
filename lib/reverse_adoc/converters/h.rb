module ReverseAdoc
  module Converters
    class H < Base
      def to_coradoc(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]" : ""
        internal_anchor = treat_children_anchors(node, state) || ""
        anchor.empty? and anchor = internal_anchor
        anchor.empty? or anchor += "\n"
        level_str = '=' * (node.name[/\d/].to_i + 1)
        content = treat_children_no_anchors(node, state)
        Coradoc::Document::Title.new(content, level_str, anchor: anchor, id: id)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def treat_children_no_anchors(node, state)
        node.children.reject { |a| a.name == "a" }.inject('') do |memo, child|
          memo << treat(child, state)
        end
      end

      def treat_children_anchors(node, state)
        node.children.select { |a| a.name == "a" }.inject('') do |memo, child|
          memo << treat(child, state)
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
