# frozen_string_literal: true

module ReverseAsciidoctor
  module Converters
    class Term < Base
      def convert(node, state = {})
        "\n=== #{node.text}\n"
      end
    end

    register :term, Term.new
  end
end
