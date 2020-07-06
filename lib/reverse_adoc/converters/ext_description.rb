# frozen_string_literal: true

module ReverseAdoc
  module Converters
    class ExtDescription < Base
      def convert(node, state = {})
        <<~TEMPLATE
          (*"#{node['linkend']}"
          #{treat_children(node, state)}
          *)
        TEMPLATE
      end
    end
    register :ext_description, ExtDescription.new
  end
end
