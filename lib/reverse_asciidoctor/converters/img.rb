module ReverseAsciidoctor
  module Converters
    class Img < Base
      def convert(node, state = {})
        alt   = node['alt']
        src   = node['src']
        id = node['id']
                anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        " ![#{alt}](#{src}#{title})"
      end
    end

    register :img, Img.new
  end
end
