module ReverseAdoc
  module Converters
    class Br < Base
      def to_coradoc(_node, _state = {})
        Coradoc::Element::Inline::HardLineBreak.new
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :br, Br.new
  end
end
