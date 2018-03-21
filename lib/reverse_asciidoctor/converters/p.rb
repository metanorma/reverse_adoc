module ReverseAsciidoctor
  module Converters
    class P < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        "\n\n#{anchor}" << treat_children(node, state).strip << "\n\n"
      end
    end

    register :p, P.new
  end
end
