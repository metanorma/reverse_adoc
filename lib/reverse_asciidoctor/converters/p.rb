module ReverseAsciidoctor
  module Converters
    class P < Base
      def convert(node, state = {})
        id = node['id']
        "\n\n" << treat_children(node, state).strip << "\n\n"
      end
    end

    register :p, P.new
  end
end
