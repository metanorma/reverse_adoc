module ReverseAdoc
  module Converters
    class Blockquote < Base
      def to_coradoc(node, state = {})
        node["id"]
        cite = node["cite"]
        attributes = if cite.nil?
                       nil
                     else
                       Coradoc::Element::AttributeList.new(
                         "quote", cite
                       )
                     end
        content = treat_children(node, state).strip
        content = ReverseAdoc.cleaner.remove_newlines(content)
        Coradoc::Element::Block::Quote.new(nil, lines: content,
                                                attributes: attributes)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :blockquote, Blockquote.new
  end
end
