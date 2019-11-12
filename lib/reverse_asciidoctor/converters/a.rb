require "uri"

module ReverseAsciidoctor
  module Converters
    class A < Base
      def convert(node, state = {})
        name  = treat_children(node, state)
        href  = node['href']
        title = extract_title(node)
        id = node['id'] || node['name']

        id = id&.gsub(/\s/, "")&.gsub(/__+/, "_")

        if !id.nil? && !id.empty?
          "[[#{id}]]"
        elsif href.to_s.start_with?('#')
          href = href.sub(/^#/, "").gsub(/\s/, "").gsub(/__+/, "_")
          if name.empty?
            "<<#{href}>>"
          else
            "<<#{href},#{name}>>"
          end
        elsif href.to_s.empty?
          name
        else
          name = title if name.empty?
          href = "link:#{href}" unless href.to_s =~ URI::DEFAULT_PARSER.make_regexp
          link = "#{href}[#{name}]"
          link.prepend(' ')
          link
        end
      end

      private

    end

    register :a, A.new
  end
end
