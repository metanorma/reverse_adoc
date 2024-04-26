# Unless run with ReverseAdoc.config.mathml2asciimath,
# this is cheating: we're injecting MathML into Asciidoctor, but
# Asciidoctor only understands AsciiMath or LaTeX

require "mathml2asciimath"

module ReverseAdoc
  module Converters
    class Math < Base
      # FIXIT
      def to_coradoc(node, state = {})
        convert(node, state)
      end

      def convert(node, _state = {})
        stem = node.to_s.gsub(/\n/, " ")
        stem = MathML2AsciiMath.m2a(stem) if ReverseAdoc.config.mathml2asciimath
        unless stem.nil?
          stem = stem.gsub(/\[/, "\\[").gsub(/\]/, "\\]").gsub(
            /\(\(([^\)]+)\)\)/, "(\\1)"
          )
        end

        # TODO: This is to be done in Coradoc
        " stem:[" << stem << "] "
      end
    end

    register :math, Math.new
  end
end
