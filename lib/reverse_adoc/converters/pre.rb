module ReverseAdoc
  module Converters
    class Pre < Base
      def to_coradoc(node, state = {})
        id = node["id"]
        lang = language(node)
        content = treat_children(node, state)

        unless lang
          return Coradoc::Element::Block::Literal.new(
            nil,
            lines: content,
            id: id,
          )
        end

        Coradoc::Element::Block::SourceCode.new(
          nil,
          lines: content,
          lang: lang,
          id: id,
        )
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      private

      def treat(node, _state)
        return "\n" if node.name == "br"

        prefix = postfix = "\n\n" if node.name == "p"

        "#{prefix}#{node.text}#{postfix}"
      end

      def language(node)
        lang = language_from_highlight_class(node)
        lang || language_from_confluence_class(node)
      end

      def language_from_highlight_class(node)
        node.parent["class"].to_s[/highlight-([a-zA-Z0-9]+)/, 1]
      end

      def language_from_confluence_class(node)
        node["class"].to_s[/brush:\s?(:?.*);/, 1]
      end
    end

    register :pre, Pre.new
  end
end
