module ReverseAsciidoctor
  module Converters
    class Img < Base
      def convert(node, state = {})
        alt   = node['alt']
        src   = node['src']
        id = node['id']
        width = node['width']
        height = node['height']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        attrs = alt
        attrs = "\"\"" if (width || height) && alt.nil?
        attrs += ",#{width}" if width
        attrs += ",#{height}" if width && height
        [anchor, title, "image::", src, "[", attrs, "]"].join("")
      end
    end

    register :img, Img.new
  end
end
