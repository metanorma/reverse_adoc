module ReverseAsciidoctor
  module Converters
    class Del < Base
      def convert(node, state = {})
        content = treat_children(node, state.merge(already_crossed_out: true))
        if content.strip.empty? || state[:already_crossed_out]
          content
        else
          "~~#{content}~~"
        end
      end

    end

    register :strike, Del.new
    register :del,    Del.new
  end
end
