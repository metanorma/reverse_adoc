module ReverseAsciidoctor
  module Converters
    class Q < Base
      def convert(node, state = {})
        content = treat_children(node, state)
        "#{content[/^\s*/]}\"#{content.strip}\"#{content[/\s*$/]}"
      end
    end

    register :q, Q.new
  end
end
