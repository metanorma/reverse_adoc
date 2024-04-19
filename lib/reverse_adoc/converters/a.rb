require "coradoc"
require "uri"

module ReverseAdoc
  module Converters
    class A < Base
      def to_coradoc(node, state ={})
        name  = treat_children(node, state)

        href  = node['href']
        title = extract_title(node)
        id = node['id'] || node['name']

        id = id&.gsub(/\s/, "")&.gsub(/__+/, "_")

        if /^_Toc\d+$|^_GoBack$/.match id
          ""
        elsif !id.nil? && !id.empty?
          Coradoc::Document::Inline::Anchor.new(id)
        elsif href.to_s.start_with?('#')
          href = href.sub(/^#/, "").gsub(/\s/, "").gsub(/__+/, "_")
          if name.to_s.empty?
            Coradoc::Document::Inline::CrossReference.new(href)
          else
            Coradoc::Document::Inline::CrossReference.new(href, name)
          end
        elsif href.to_s.empty?
          name
        else
          Coradoc::Document::Inline::Link.new(path: href, name: name, title: title)
        end
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      private

    end

    register :a, A.new
  end
end
