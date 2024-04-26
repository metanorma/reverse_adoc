module ReverseAdoc
  module Converters
    class Em < Base
      def to_coradoc(node, state = {})
        content = treat_children_coradoc(node,
                                         state.merge(already_italic: true))

        if Coradoc::Generator.gen_adoc(content).strip.empty?
          return ""
        end

        if node_has_ancestor?(node, ["em", "i", "cite"])
          return content
        end

        node.text =~ /^(\s+)/
        leading_whitespace = $1
        has_leading_whitespace = !leading_whitespace.nil?

        if has_leading_whitespace
          first_text = node.at_xpath("./text()[1]")
          first_text.replace(first_text.text.lstrip)
          leading_whitespace = " "
        end

        node.text =~ /(\s+)$/
        trailing_whitespace = $1
        has_trailing_whitespace = !trailing_whitespace.nil?

        if has_trailing_whitespace
          last_text = node.at_xpath("./text()[last()]")
          last_text.replace(last_text.text.rstrip)
          trailing_whitespace = " "
        end

        u_before = unconstrained_before?(node)
        u_after = unconstrained_after?(node)
        u = !((!u_before || has_leading_whitespace) && (!u_after || has_trailing_whitespace))
        e = Coradoc::Element::Inline::Italic.new(
          Coradoc::Element::TextElement.new(content), u
        )

        [leading_whitespace, e, trailing_whitespace]
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
