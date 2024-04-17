module ReverseAdoc
  module Converters
    class Blockquote < Base
      def to_coradoc(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        cite = node['cite']
        attrs = cite ? "[quote, #{cite}]\n" : ""
        content = treat_children(node, state).strip
        content = ReverseAdoc.cleaner.remove_newlines(content)
        Coradoc::Document::Block.new(nil, lines: content.lines, type: :quote, attributes: attrs)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :blockquote, Blockquote.new
  end
end
