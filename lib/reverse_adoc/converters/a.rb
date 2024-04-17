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

        Coradoc::Document::Inline::Anchor.new(id: id, href: href, title: title, name: name)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end

      private

    end

    register :a, A.new
  end
end
