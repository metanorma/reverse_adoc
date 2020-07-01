# frozen_string_literal: true

module ReverseAsciidoctor
  module Converters
    class Note < Base
      def convert(node, state = {})
        <<~TEMPLATE
          \n
          [NOTE]
          --
          #{treat_children(node, state)}
          --
        TEMPLATE
      end
    end
    register :note, Note.new
  end
end
