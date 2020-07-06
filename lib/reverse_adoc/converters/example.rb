# frozen_string_literal: true

module ReverseAdoc
  module Converters
    class Example < Base
      def convert(node, state = {})
        <<~TEMPLATE
          [example]
          ====
          #{treat_children(node, state)}
          ====
        TEMPLATE
      end
    end
    register :example, Example.new
  end
end
