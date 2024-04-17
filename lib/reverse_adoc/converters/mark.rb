module ReverseAdoc
  module Converters
    class Mark < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state.merge(already_strong: true))
        if content.strip.empty? || state[:already_strong]
          content
        else
          Coradoc::Document::Inline::Highlight.new(content)
        end
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node,state))
      end
    end

    register :mark, Mark.new
  end
end
