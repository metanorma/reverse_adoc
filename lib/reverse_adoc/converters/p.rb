module ReverseAdoc
  module Converters
    class P < Base
      def to_coradoc(node, state = {})
        id = node["id"]
        content = treat_children_coradoc(node, state)

        options = {}.tap do |hash|
          hash[:id] = id if id
          hash[:tdsinglepara] = true if state[:tdsinglepara]
        end

        Coradoc::Element::Paragraph.new(content, options)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :p, P.new
  end
end
