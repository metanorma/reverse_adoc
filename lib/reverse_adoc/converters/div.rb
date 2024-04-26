module ReverseAdoc
  module Converters
    class Div < Base
      def to_coradoc(node, state = {})
        id = node["id"]
        contents = treat_children_coradoc(node, state)
        Coradoc::Element::Section.new(nil, id: id, contents: contents)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :div,     Div.new
    register :article, Div.new
  end
end
