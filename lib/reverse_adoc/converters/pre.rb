module ReverseAdoc
  module Converters
    class Pre < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        lang = language(node)
        content = treat_children(node, state)
        if lang
          "\n\n#{anchor}[source,#{lang}]\n----\n" << content.lines.to_a.join("") << "\n----\n\n"
        else
          "\n\n#{anchor}....\n" << content.lines.to_a.join("") << "\n....\n\n"
        end
      end

      private

      def treat(node, state)
        return "\n" if node.name == "br"

        prefix = postfix = "\n\n" if node.name == "p"

        "#{prefix}#{node.text}#{postfix}"
      end

      def language(node)
        lang = language_from_highlight_class(node)
        lang || language_from_confluence_class(node)
      end

      def language_from_highlight_class(node)
        node.parent['class'].to_s[/highlight-([a-zA-Z0-9]+)/, 1]
      end

      def language_from_confluence_class(node)
        node['class'].to_s[/brush:\s?(:?.*);/, 1]
      end
    end

    register :pre, Pre.new
  end
end
