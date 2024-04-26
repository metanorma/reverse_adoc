require "coradoc"

module ReverseAdoc
  module Converters
    class A < Base
      def to_coradoc(node, state = {})
        name  = treat_children(node, state)

        href  = node["href"]
        title = extract_title(node)
        id = node["id"] || node["name"]

        id = id&.gsub(/\s/, "")&.gsub(/__+/, "_")

        return "" if /^_Toc\d+$|^_GoBack$/.match?(id)

        if !id.nil? && !id.empty?
          return Coradoc::Element::Inline::Anchor.new(id)
        end

        if href.to_s.start_with?("#")
          href = href.sub(/^#/, "").gsub(/\s/, "").gsub(/__+/, "_")
          return Coradoc::Element::Inline::CrossReference.new(href, name)
        end

        if href.to_s.empty?
          return name
        end

        Coradoc::Element::Inline::Link.new(path: href,
                                           name: name,
                                           title: title)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :a, A.new
  end
end
