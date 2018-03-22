module ReverseAsciidoctor
  module Converters
    class Div < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        "\n#{anchor}" << treat_children(node, state) << "\n"
      end
    end

    register :div,     Div.new
    register :article, Div.new
    register :details, Div.new
  end
end
