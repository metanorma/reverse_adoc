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

      def treat_children_coradoc(node, state)
        node.children.inject([]) do |memo, child|
          memo << treat_coradoc(child, state)
        end.flatten.reject{|x| x=="" || x.nil?}
      end

      def treat_coradoc(node, state)
        ReverseAdoc::Converters.lookup(node.name).to_coradoc(node, state)
      end

      def escape_keychars(string)
        subs = { '*' => '\*', '_' => '\_' }
        string
          .gsub(/((?<=\s)[\*_]+)|[\*_]+(?=\s)/) { |n| n.chars.map { |char| subs[char] }.join }
      end

      def extract_title(node)
        title = escape_keychars(node['title'].to_s)
        title.empty? ? '' : %[ #{title}]
      end
    end
  end
end
