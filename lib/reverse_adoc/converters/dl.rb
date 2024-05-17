module ReverseAdoc
  module Converters
    class Dl < Base
      def to_coradoc(node, state = {})
        items = process_dl(node, state)
        items2 = items.map do |item|
          Coradoc::Element::ListItemDefinition.new(item[:name], item[:value])
        end
        Coradoc::Element::List::Definition.new(items2, delimiter: "::")
      end

      def process_dl(node, state = {})
        groups = []
        current = {name: [], value: []}

        seen_dd = false
        child = node.at_xpath("*[1]")
        grandchild = nil
        while !child.nil?
          if child.name == "div"
            grandchild = child.at_xpath("*[1]")
            while !grandchild.nil?
              groups, current, seen_dd = process_dt_or_dd(groups, current, seen_dd, grandchild, state)
              grandchild = grandchild.at_xpath("following-sibling::*[1]")
            end
          elsif ["dt", "dd"].include?(child.name)
            groups, current, seen_dd = process_dt_or_dd(groups, current, seen_dd, child, state)
            child = child.at_xpath("following-sibling::*[1]")
          end
          if current[:name].any? && current[:value].any?
            groups << current
          end
        end
        groups
      end

      def process_dt_or_dd(groups, current, seen_dd, subnode, state = {})
        if subnode.name == "dt"
          if seen_dd
            # groups << current
            current = {name: [], value: []}
            seen_dd = false
          end
          current[:name] += treat_children_coradoc(subnode, state)
        elsif subnode.name == "dd"
          current[:value] += treat_children_coradoc(subnode, state)
          seen_dd = true
        end
        [groups, current, seen_dd]
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :dl, Dl.new
  end
end
