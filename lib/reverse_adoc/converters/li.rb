module ReverseAdoc
  module Converters
    class Li < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]" : ""
        content     = treat_children(node, state)
        prefix      = prefix_for(node, state)
        "#{prefix} #{anchor}#{content.chomp}\n"
      end

      def prefix_for(node, state)
        length = state.fetch(:ol_count, 0)
        if node.parent.name == 'ol'
          "." * [length, 0].max
        else
          "*" * [length, 0].max
        end
      end
    end

    register :li, Li.new
  end
end
