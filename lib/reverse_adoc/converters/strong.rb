module ReverseAdoc
  module Converters
    class Strong < Base
      def to_coradoc(node, state = {})
        content = treat_children_coradoc(node,
                                         state.merge(already_strong: true))

        if Coradoc::Generator.gen_adoc(content).strip.empty?
          return ""
        end

        if node_has_ancestor?(node, ["strong", "b"])
          return content
        end

        u_before = unconstrained_before?(node)
        u_after = unconstrained_after?(node)
        node.text =~ /^(\s+)/
        leading_whitespace = $1
        has_leading_whitespace = !leading_whitespace.nil?

        if has_leading_whitespace
          first_text = node.at_xpath("./text()[1]")
          first_text.replace(first_text.text.lstrip)
          leading_whitespace = u_before ? " " : " " # ########################33   somethings wrong in here
        end

        node.text =~ /(\s+)$/
        trailing_whitespace = $1
        has_trailing_whitespace = !trailing_whitespace.nil?

        if has_trailing_whitespace
          last_text = node.at_xpath("./text()[last()]")
          last_text.replace(last_text.text.rstrip)
          trailing_whitespace = u_after ? "" : "" ###############################
        end

        u = !((!u_before || has_leading_whitespace) && (!u_after || has_trailing_whitespace))
        e = Coradoc::Element::Inline::Bold.new(content, u)

        [leading_whitespace, e, trailing_whitespace]
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :strong, Strong.new
    register :b,      Strong.new
  end
end
