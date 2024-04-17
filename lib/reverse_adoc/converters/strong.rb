module ReverseAdoc
  module Converters
    class Strong < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state.merge(already_strong: true))
        if content.strip.empty? || state[:already_strong]
          content
        else
          Coradoc::Document::Inline::Bold.new(content)
        end
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node,state))
      end
    end

    register :strong, Strong.new
    register :b,      Strong.new
  end
end
