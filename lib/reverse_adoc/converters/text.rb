module ReverseAdoc
  module Converters
    class Text < Base
      def to_coradoc(node, state = {})
        return treat_empty(node, state) if node.text.strip.empty?

        Coradoc::Element::TextElement.new(treat_text(node))
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      private

      def treat_empty(node, state)
        parent = node.parent.name.to_sym
        if %i[ol ul].include?(parent) # Otherwise the identation is broken
          ""
        elsif state[:tdsinglepara]
          ""
        elsif node.text == " " # Regular whitespace text node
          " "
        else
          ""
        end
      end

      def treat_text(node)
        text = node.text
        text = preserve_nbsp(text)
        text = remove_border_newlines(text)
        text = remove_inner_newlines(text)
        text = escape_keychars(text)

        text = preserve_keychars_within_backticks(text)
        escape_links(text)
      end

      def preserve_nbsp(text)
        text.gsub(/\u00A0/, "&nbsp;")
      end

      def escape_links(text)
        text.gsub(/<<([^>]*)>>/, "\\<<\\1>>")
      end

      def remove_border_newlines(text)
        text.gsub(/\A\n+/, "").gsub(/\n+\z/, "")
      end

      def remove_inner_newlines(text)
        text.tr("\n\t", " ").squeeze(" ")
      end

      def preserve_keychars_within_backticks(text)
        text.gsub(/`.*?`/) do |match|
          match.gsub('\_', "_").gsub('\*', "*")
        end
      end
    end

    register :text, Text.new
  end
end
