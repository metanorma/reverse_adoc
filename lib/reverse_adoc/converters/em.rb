module ReverseAdoc
  module Converters
    class Em < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state.merge(already_italic: true))
        if content.strip.empty? || state[:already_italic]
          content
        else
          Coradoc::Document::Inline::Italic.new(Coradoc::Document::TextElement.new(content))
        end
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node,state))
      end
    end

    register :em, Em.new
    register :i,  Em.new
    register :cite,  Em.new
  end
end
