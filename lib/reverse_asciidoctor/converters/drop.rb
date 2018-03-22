module ReverseAsciidoctor
  module Converters
    class Drop < Base
      def convert(node, state = {})
        ''
      end
    end

    register :caption, Drop.new
    register :figcaption, Drop.new
    register :title, Drop.new
    register :link, Drop.new
    register :style, Drop.new
    register :meta, Drop.new
  end
end
