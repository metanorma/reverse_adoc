module ReverseAdoc
  module Converters
    class Br < Base
      def convert(node, state = {})
        " +\n"
      end
    end

    register :br, Br.new
  end
end
