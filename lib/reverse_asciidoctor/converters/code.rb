module ReverseAsciidoctor
  module Converters
    class Code < Base
      def convert(node, state = {})
        "`#{node.text}`"
      end
    end

    register :code, Code.new
    register :tt, Code.new
    register :kbd, Code.new
    register :samp, Code.new
  end
end
