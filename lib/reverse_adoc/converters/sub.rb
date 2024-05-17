module ReverseAdoc
  module Converters
    class Sub < Base
      def to_coradoc(node, state = {})
        leading_whitespace, trailing_whitespace = extract_leading_trailing_whitespace(node)

        content = treat_children_coradoc(node, state)

        return content if Coradoc::Generator.gen_adoc(content).strip.empty?

        e = Coradoc::Element::Inline::Subscript.new(content)
        [leading_whitespace, e, trailing_whitespace]
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :sub, Sub.new
  end
end
