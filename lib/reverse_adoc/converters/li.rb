module ReverseAdoc
  module Converters
    class Li < Base
      def to_coradoc(node, state = {})
        id = node["id"]
        content = treat_children_coradoc(node, state)
        Coradoc::Element::ListItem.new(content, id: id)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :li, Li.new
  end
end
