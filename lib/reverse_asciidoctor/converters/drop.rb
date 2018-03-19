module ReverseAsciidoctor
  module Converters
    class Drop < Base
      def convert(node, state = {})
        ''
      end
    end
  end
end
