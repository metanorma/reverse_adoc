module ReverseAdoc
  module Converters
    class Base
      def treat_children(node, state)
        node.children.inject("") do |memo, child|
          memo << treat(child, state)
        end
      end

      def treat(node, state)
        ReverseAdoc::Converters.lookup(node.name).convert(node, state)
      end

      def treat_children_coradoc(node, state)
        node.children.inject([]) do |memo, child|
          memo << treat_coradoc(child, state)
        end.flatten.reject { |x| x == "" || x.nil? }
      end

      def treat_coradoc(node, state)
        ReverseAdoc::Converters.lookup(node.name).to_coradoc(node, state)
      end

      def escape_keychars(string)
        subs = { "*" => '\*', "_" => '\_' }
        string
          .gsub(/((?<=\s)[\*_]+)|[\*_]+(?=\s)/) do |n|
          n.chars.map do |char|
            subs[char]
          end.join
        end
      end

      def extract_title(node)
        title = escape_keychars(node["title"].to_s)
        title.empty? ? "" : %[ #{title}]
      end

      def node_has_ancestor?(node, name)
        case name
        when String
          node.ancestors.map(&:name).include?(name)
        when Array
          (node.ancestors.map(&:name) & name).any?
        end
      end

      def textnode_before_end_with?(node, str)
        return nil if !str.is_a?(String) || str.empty?

        node2 = node.at_xpath("preceding-sibling::node()[1]")
        node2.respond_to?(:text) && node2.text.end_with?(str)
      end

      def unconstrained_before?(node)
        before = node.at_xpath("preceding::node()[1]")

        before &&
          !before.text.strip.empty? &&
          before.text[-1]&.match?(/\w/)
      end

      # TODO: This logic ought to be cleaned up.
      def unconstrained_after?(node)
        after = node.at_xpath("following::node()[1]")

        after && !after.text.strip.empty? &&
          after.text[0]&.match?(/\w|,|;|"|\.\?!/)
      end

      # def trailing_whitespace?(node)

      # TODO: This logic ought to be cleaned up.
      def constrained?(node)
        before = node.at_xpath("preceding::node()[1]").to_s[-1]
        before = if before
                   before&.match?(/\s/) ? true : false
                 else
                   true
                 end

        if !before && (node.to_s[0] =~ /\s/)
          before = true
        end

        after = node.at_xpath("following::node()[1]").to_s[0]
        after = if after
                  after&.match?(/\s|,|;|"|\.\?!/) ? true : false
                else
                  true
                end
        if !after && (node.to_s[-1] =~ /\s/)
          after = true
        end

        before && after
      end
    end
  end
end
