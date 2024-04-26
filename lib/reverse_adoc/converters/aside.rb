module ReverseAdoc
  module Converters
    class Aside < Base
      def to_coradoc(node, state = {})
        content = treat_children(node, state)
        Coradoc::Element::Block::Side.new(lines: content.lines)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :aside, Aside.new
  end
end
