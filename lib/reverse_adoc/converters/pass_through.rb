module ReverseAdoc
  module Converters
    class PassThrough < Base
      def to_coradoc(node, _state = {})
        node.to_s
      end

      def convert(node, state = {})
        to_coradoc(node, state)
      end
    end
  end
end
