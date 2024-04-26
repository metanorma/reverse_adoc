# Unless run with ReverseAdoc.config.mathml2asciimath,
# this is cheating: we're injecting MathML into Asciidoctor, but
# Asciidoctor only understands AsciiMath or LaTeX

require "mathml2asciimath"

module ReverseAdoc
  module Converters
    class Math < Base
      def to_coradoc(node, state = {}) #FIXIT
        convert(node, state)
      end
      def convert(node, state = {})
        stem = node.to_s.gsub(/\n/, " ")
        stem = MathML2AsciiMath.m2a(stem) if ReverseAdoc.config.mathml2asciimath
        stem = stem.gsub(/\[/, "\\[").gsub(/\]/, "\\]").gsub(/\(\(([^\)]+)\)\)/, "(\\1)") unless stem.nil?
        " stem:[" << stem << "] "
      end
    end

    register :math, Math.new
  end
end
