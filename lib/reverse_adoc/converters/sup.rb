module ReverseAdoc
  module Converters
    class Sup < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state)
        Coradoc::Element::Inline::Superscript.new(content)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :sup, Sup.new
  end
end
