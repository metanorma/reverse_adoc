module ReverseAsciidoctor
  module Converters
    class Def < Base
      def convert(node, state = {})
        "\n#{treat_children(node, state)}\n"
      end
    end

    register :def, Def.new
  end
end
