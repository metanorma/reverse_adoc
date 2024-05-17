module ReverseAdoc
  module Converters
    class Em < Base
      def to_coradoc(node, state = {})
        u_before = unconstrained_before?(node)
        u_after = unconstrained_after?(node)

        leading_whitespace, trailing_whitespace = extract_leading_trailing_whitespace(node)

        content = treat_children_coradoc(node, state)

        if Coradoc::Generator.gen_adoc(content).strip.empty? || node_has_ancestor?(node, ["em","i","cite"])
          content
        else
          u = !((!u_before || !leading_whitespace.nil?) && (!u_after || !trailing_whitespace.nil?))
          e = Coradoc::Element::Inline::Italic.new(content, u)
          [leading_whitespace, e, trailing_whitespace]
        end
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :em, Em.new
    register :i,  Em.new
    register :cite, Em.new
  end
end
