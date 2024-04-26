module ReverseAdoc
  module Converters
    class Ol < Base
      # FIXIT
      def to_coradoc(node, state = {})
        # convert(node, state)
        id = node["id"]
        ol_count = state.fetch(:ol_count, 0) + 1
        attrs = ol_attrs(node)
        items = treat_children_coradoc(node, state.merge(ol_count: ol_count))

        options = {}.tap do |hash|
          hash[:id] = id
          hash[:ol_count] = ol_count
          hash[:attrs] = attrs
        end

        case get_list_type(node, state)
        when :ordered
          Coradoc::Element::List::Ordered.new(items, options)
        when :unordered
          Coradoc::Element::List::Unordered.new(items, options)
        end
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def get_list_type(node, _state)
        case node.name
        when "ol"
          :ordered
        when "ul"
          :unordered
        end
      end

      def number_style(node)
        case node["style"]
        when "1" then "arabic"
        when "A" then "upperalpha"
        when "a" then "loweralpha"
        when "I" then "upperroman"
        when "i" then "lowerroman"
        end
      end

      def ol_attrs(node)
        attrs = Coradoc::Element::AttributeList.new
        style = number_style(node)
        attrs.add_positional(style) if style
        attrs.add_positional("%reversed") if node["reversed"]
        attrs.add_named("start", node["start"]) if node["start"]
        attrs.add_named("type", node["type"]) if node["type"]
        attrs
      end
    end

    register :ol, Ol.new
    register :ul, Ol.new
    register :dir, Ol.new
  end
end
