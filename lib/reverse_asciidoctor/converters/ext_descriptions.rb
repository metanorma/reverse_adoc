# frozen_string_literal: true

module ReverseAsciidoctor
  module Converters
    class ExtDescriptions < Base
      def convert(node, state = {})
        treat_children(node, state)
      end
    end
    register :ext_descriptions, ExtDescriptions.new
  end
end
