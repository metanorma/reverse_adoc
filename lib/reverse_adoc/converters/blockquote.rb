module ReverseAdoc
  module Converters
    class Blockquote < Base
      def to_coradoc(node, state = {})
        id = node['id']
        cite = node['cite']
        attributes = cite.nil? ? nil :  Coradoc::Document::AttributeList.new("quote", cite)
        content = treat_children(node, state).strip
        content = ReverseAdoc.cleaner.remove_newlines(content)
        Coradoc::Document::Block::Quote.new(nil, lines: content, attributes: attributes)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :blockquote, Blockquote.new
  end
end
