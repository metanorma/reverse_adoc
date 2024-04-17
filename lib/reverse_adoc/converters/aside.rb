module ReverseAdoc
  module Converters
    class Aside < Base
      def to_coradoc(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        content = treat_children(node, state)#.strip
        Coradoc::Document::Block.new(nil, lines: content.lines, type: :side)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node,state))
      end
    end

    register :aside, Aside.new
  end
end
