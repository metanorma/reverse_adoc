# frozen_string_literal: true

module ReverseAdoc
  module Converters
    class Note < Base
      def convert(node, state = {})
        <<~TEMPLATE
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
