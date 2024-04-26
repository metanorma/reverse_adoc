module ReverseAdoc
  module Converters
    class Q < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state)
        Coradoc::Element::Inline::Quotation.new(content)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :q, Q.new
  end
end
