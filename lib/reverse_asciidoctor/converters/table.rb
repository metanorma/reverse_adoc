module ReverseAsciidoctor
  module Converters
    class Table < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        attrs = style(node)
        "\n\n#{anchor}#{attrs}#{title}|===\n" << treat_children(node, state) << "\n|===\n"
      end

      def extract_title(node)
        title = node.at("./caption")
        return "" if title.nil?
        treat_children(title, {})
      end

      def frame(node)
        case node["frame"]
        when "void"
          "frame=none"
        when "hsides"
          "frame=topbot"
        when "vsides"
          "frame=sides"
        when "box", "border"
          "frame=all"
        else
          nil
        end
      end

      def rules(node)
        case node["rules"]
        when "all"
          "rules=all"
        when "rows"
          "rules=rows"
        when "cols"
          "rules=cols"
        when "none"
          "rules=none"
          else
          nil
        end
      end

      def style(node)
        width = "width=#{node['width']}" if node['width']
        attrs = []
        frame_attr = frame(node)
        rules_attr = rules(node)
        attrs << width if width
        attrs << frame_attr if frame_attr
        attrs << rules_attr if rules_attr
        return "" if attrs.empty?
        "[#{attrs.join(',')}]\n"
      end
    end

    register :table, Table.new
  end
end
