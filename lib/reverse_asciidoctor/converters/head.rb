module ReverseAsciidoctor
  module Converters
    class Head < Base
      def convert(node, state = {})
        title = extract_title(node)
        "= #{title}\n:stem:\n\n"
      end

      def extract_title(node)
        title = node.at("./title")
        return "(???)" if title.nil?
        treat_children(title, {})
      end
    end

    register :head, Head.new
  end
end
