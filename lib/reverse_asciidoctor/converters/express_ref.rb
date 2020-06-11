# frozen_string_literal: true

module ReverseAsciidoctor
  module Converters
    class ExpressRef < Base
      def convert(node, _state = {})
        "express_ref:[#{node['linkend']}]"
      end
    end
    register :express_ref, ExpressRef.new
  end
end
