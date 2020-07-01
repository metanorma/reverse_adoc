module ReverseAsciidoctor
  module Converters
    class Definition < Base
      def convert(node, state = {})
        treat_children(node, state)
      end
    end

    register :definition, Definition.new
  end
end
