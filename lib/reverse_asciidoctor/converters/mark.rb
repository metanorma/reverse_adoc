module ReverseAsciidoctor
  module Converters
    class Mark < Base
      def convert(node, state = {})
        content = treat_children(node, state)
          "#{content[/^\s*/]}##{content.strip}##{content[/\s*$/]}"
      end
    end

    register :mark, Mark.new
  end
end
