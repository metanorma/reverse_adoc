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

      def node_has_ancestor?(node, name)
        if name.is_a?(String)
          node.ancestors.map(&:name).include?(name)
        elsif name.is_a?(Array)
          (node.ancestors.map(&:name) & name).any?
        end
      end

      def textnode_before_end_with?(node, str)
        return nil if (!str.is_a?(String) || !(str.size>=1))
        node2 = node.at_xpath("preceding-sibling::node()[1]")
        node2.respond_to?(:text) && node2.text.end_with?(str)
      end

      def unconstrained_before?(node)
        before = node.at_xpath("preceding::node()[1]")
        if before && !before.text.strip.empty?
          before = (before.text[-1] =~ (/\w/)) ? true : false
        else
          before = false
        end
      end        

      def unconstrained_after?(node)
        after = node.at_xpath("following::node()[1]")
        if after && !after.text.strip.empty?
          after = (after.text[0] =~ (/\w|,|;|\"|\.\?\!/)) ? true : false
        else
          after = false
        end
      end

      #def trailing_whitespace?(node)

      def constrained?(node)
        before = node.at_xpath("preceding::node()[1]").to_s[-1]
        if before
          before = (before =~ (/\s/)) ? true : false
        else
          before = true
        end
        if !before
          before = true if node.to_s[0] =~ /\s/
        end
        
        after = node.at_xpath("following::node()[1]").to_s[0]
        if after
          after = (after =~ (/\s|,|;|\"|\.\?\!/)) ? true : false
        else
          after = true
        end
        if !after
          after = true if node.to_s[-1] =~ /\s/
        end
        
        before && after
      end

    end
  end
end
