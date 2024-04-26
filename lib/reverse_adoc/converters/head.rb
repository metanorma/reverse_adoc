module ReverseAdoc
  module Converters
    class Head < Base
      def to_coradoc(node, _state = {})
        title = extract_title(node)
        Coradoc::Element::Header.new(title)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def extract_title(node)
        title = node.at("./title")
        return "(???)" if title.nil?

        title.text
      end
    end

    register :head, Head.new
  end
end
