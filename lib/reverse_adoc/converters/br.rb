module ReverseAdoc
  module Converters
    class Br < Base
      def to_coradoc(node, state = {})
        Coradoc::Document::Inline::HardLineBreak.new
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :br, Br.new
  end
end
