module ReverseAdoc
  module Converters
    class Sub < Base
      def to_coradoc(node, state = {})
        content = treat_children_coradoc(node, state)
        Coradoc::Element::Inline::Subscript.new(content)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :sub, Sub.new
  end
end
