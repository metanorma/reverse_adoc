# Unless run with ReverseAdoc.config.mathml2asciimath,
# this is cheating: we're injecting MathML into Asciidoctor, but
# Asciidoctor only understands AsciiMath or LaTeX

require "mathml2asciimath"

module ReverseAdoc
  module Converters
    class Math < Base
      def convert(node, state = {})
        stem = node.to_s.gsub(/\n/, " ")
        stem = translate_expression(stem)
        stem = escape_square_brackets(stem)
        stem = remove_redundant_round_brackets(stem)
        " stem:[#{stem}] "
      end

      # Translates MathML to AsciiMath, if that's enabled.
      def translate_expression(str)
        if ReverseAdoc.config.mathml2asciimath
          MathML2AsciiMath.m2a(str)
        else
          str
        end
      end

      # Precedes square brackets with a +\+.
      def escape_square_brackets(str)
        str.gsub(/\[/, "\\[").gsub(/\]/, "\\]") unless str.nil?
      end

      # Removes reundant round brackets like in +((...))+.
      #
      # For some short discussion, see:
      # https://github.com/metanorma/reverse_adoc/issues/67
      def remove_redundant_round_brackets(str)
        str.gsub(/\(\(([^\)]+)\)\)/, "(\\1)") unless str.nil?
      end
    end

    register :math, Math.new
  end
end
