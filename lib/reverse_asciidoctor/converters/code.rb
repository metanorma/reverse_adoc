module ReverseAsciidoctor
  module Converters
    class Code < Base
      def convert(node, state = {})
        "`#{node.text}`"
      end
    end

    register :code, Code.new
    register :tt, Code.new
  end
end
