module ReverseAdoc
  module Converters
    class Sup < Base
      def convert(node, state = {})
        content = treat_children(node, state)
        "#{content[/^\s*/]}^#{content.strip}^#{content[/\s*$/]}"
      end
    end

    register :sup, Sup.new
  end
end
