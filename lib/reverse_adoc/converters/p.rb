module ReverseAdoc
  module Converters
    class P < Base
      def to_coradoc(node, state = {})
        id = node['id']
        content = treat_children(node, state).strip
        options = {}
        options[:id] = id if id
        options[:tdsinglepara] = true if state[:tdsinglepara]
        Coradoc::Document::Paragraph.new(content, options)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :p, P.new
  end
end
