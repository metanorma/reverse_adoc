module ReverseAdoc
  module Converters
    class Code < Base
      def to_coradoc(node, state = {})
        u_before = unconstrained_before?(node)
        u_after = unconstrained_after?(node)

        leading_whitespace, trailing_whitespace = extract_leading_trailing_whitespace(node)

        content = treat_children_coradoc(node, state)

        if Coradoc::Generator.gen_adoc(content).strip.empty? || node_has_ancestor?(node, ["code","tt","kbd","samp","var"])
          content
        else
          u = !((!u_before || !leading_whitespace.nil?) && (!u_after || !trailing_whitespace.nil?))
          e = Coradoc::Element::Inline::Monospace.new(content, u)
          [leading_whitespace, e, trailing_whitespace]
        end
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
