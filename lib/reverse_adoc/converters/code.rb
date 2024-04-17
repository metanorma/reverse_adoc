module ReverseAdoc
  module Converters
    class Code < Base
      def to_coradoc(node, state = {})
        Coradoc::Document::Inline::Monospace.new(node.text)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :code, Code.new
    register :tt, Code.new
    register :kbd, Code.new
    register :samp, Code.new
    register :var, Code.new
  end
end
