module ReverseAdoc
  module Converters
    class Video < Base
      def to_coradoc(node, _state = {})
        src = node["src"]
        id = node["id"]
        title = extract_title(node)
        attributes = Coradoc::Element::AttributeList.new
        options = options(node)
        attributes.add_named("options", options) if options.any?
        Coradoc::Element::Video.new(title, id: id, src: src,
                                           attributes: attributes)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      def options(node)
        autoplay = node["autoplay"]
        loop_attr = node["loop"]
        controls = node["controls"]
        [autoplay, loop_attr, controls].compact
      end
    end

    register :video, Video.new
  end
end
