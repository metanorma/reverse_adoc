# frozen_string_literal: true

module ReverseAsciidoctor
  module Converters
    class Synonym < Base
      def convert(node, state = {})
        "\nalt:[#{node.text}]\n"
      end
    end

    register :synonym, Synonym.new
  end
end
