module ReverseAdoc
  module Converters
    class Hr < Base
      def to_coradoc(_node, _state = {})
        Coradoc::Element::Break::ThematicBreak.new
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :hr, Hr.new
  end
end
