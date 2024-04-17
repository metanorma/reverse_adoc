module ReverseAdoc
  module Converters
    class Audio < Base
      def to_coradoc(node, state = {})
        src   = node['src']
        id = node['id']
        title = extract_title(node)
        Coradoc::Document::Audio.new(title, id: id, src: src, options: options(node))
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def options(node)
        autoplay   = node['autoplay']
        loop_attr   = node['loop']
        controls   = node['controls']
        [autoplay, loop_attr, controls].compact
      end
    end

    register :audio, Audio.new
  end
end
