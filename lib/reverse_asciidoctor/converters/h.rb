module ReverseAsciidoctor
  module Converters
    class H < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        prefix = '=' * (node.name[/\d/].to_i + 1)
        ["\n", anchor, prefix, ' ', treat_children(node, state), "\n"].join
      end
    end

    register :h1, H.new
    register :h2, H.new
    register :h3, H.new
    register :h4, H.new
    register :h5, H.new
    register :h6, H.new
  end
end
