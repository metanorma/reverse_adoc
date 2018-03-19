module ReverseAsciidoctor
  module Converters
    class Blockquote < Base
      def convert(node, state = {})
        id = node['id']
        content = treat_children(node, state).strip
        content = ReverseAsciidoctor.cleaner.remove_newlines(content)
        "\n\n> " << content.lines.to_a.join('> ') << "\n\n"
      end
    end

    register :blockquote, Blockquote.new
  end
end
