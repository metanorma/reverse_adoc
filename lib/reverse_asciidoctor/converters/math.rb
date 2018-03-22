# This is cheating: we're injecting MathML into Asciidoctor, but
# Asciidoctor only understands AsciiMath or LaTeX

module ReverseAsciidoctor
  module Converters
    class Math < Base
      def convert(node, state = {})
        "stem:[" << node.to_s.gsub(/\n/, " ") << "]"
      end
    end

    register :math, Math.new
  end
end
