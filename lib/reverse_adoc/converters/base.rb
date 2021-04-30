module ReverseAdoc
  module Converters
    class Base
      def treat_children(node, state)
        node.children.inject('') do |memo, child|
          memo << treat(child, state)
        end
      end

      def treat(node, state)
        ReverseAdoc::Converters.lookup(node.name).convert(node, state)
      end

      def escape_keychars(string)
        string
          .gsub(/(?<!\\)_+\b|\b(?<!\\)_+/) { |n| n.chars.map {|_| '\_'}.join }
          .gsub(/(?<!\\)\*/, '\*')
      end

      def extract_title(node)
        title = escape_keychars(node['title'].to_s)
        title.empty? ? '' : %[ #{title}]
      end
    end
  end
end
