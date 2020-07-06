module ReverseAdoc
  module Converters
    class H < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]" : ""
        internal_anchor = treat_children_anchors(node, state) || ""
        anchor.empty? and anchor = internal_anchor
        anchor.empty? or anchor += "\n"
        prefix = '=' * (node.name[/\d/].to_i + 1)
        ["\n", anchor, prefix, ' ', treat_children_no_anchors(node, state), "\n"].join
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
