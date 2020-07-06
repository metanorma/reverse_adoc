module ReverseAdoc
  module Converters
    class Sub < Base
      def convert(node, state = {})
        content = treat_children(node, state)
        "#{content[/^\s*/]}~#{content.strip}~#{content[/\s*$/]}"
      end
    end

    register :sub, Sub.new
  end
end
