module ReverseAsciidoctor
  module Converters
    class Audio < Base
      def convert(node, state = {})
        autoplay   = node['autoplay']
        loop_attr   = node['loop']
        controls   = node['controls']
        src   = node['src']
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)
        title = ".#{title}\n" unless title.empty?
        [anchor, title, "audio::", src, "[", options(node), "]"].join("")
      end

      def options(node)
        autoplay   = node['autoplay']
        loop_attr   = node['loop']
        controls   = node['controls']
        ret = ""
        if autoplay || loop_attr || controls
          out = []
          out << "autoplay" if autoplay
          out << "loop" if loop_attr
          out << "controls" if controls
          ret = %{options="#{out.join(',')}"}
        end
        ret
      end
    end

    register :audio, Audio.new
  end
end
