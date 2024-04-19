module ReverseAdoc
  module Converters
    class Table < Base
      def to_coradoc(node, state = {})
        id = node['id']
        title = extract_title(node)
        attrs = style(node)
        content = treat_children_coradoc(node, state)
        Coradoc::Document::Table.new(title, content, {id: id, attrs: attrs})
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc( to_coradoc(node, state) )
      end

      def extract_title(node)
        title = node.at("./caption")
        return "" if title.nil?
        treat_children(title, {})
      end

      def frame(node)
        case node["frame"]
        when "void"
          "none"
        when "hsides"
          "topbot"
        when "vsides"
          "sides"
        when "box", "border"
          "all"
        else
          nil
        end
      end

      def rules(node)
        case node["rules"]
        when "all"
          "all"
        when "rows"
          "rows"
        when "cols"
          "cols"
        when "none"
          "none"
        else
          nil
        end
      end

      def style(node)
        attrs = Coradoc::Document::AttributeList.new
        attrs.add_named("width", node["width"]) if node["width"]
        frame_attr = frame(node)
        attrs.add_named("frame", frame_attr) if frame_attr
        rules_attr = rules(node)
        attrs.add_named("rules", rules_attr) if rules_attr
        return "" if attrs.empty?
        attrs
      end
    end

    register :table, Table.new
  end
end
