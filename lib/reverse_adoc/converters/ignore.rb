module ReverseAdoc
  module Converters
    class Ignore < Base
      def to_coradoc(node, state = {})
        convert(node,state)
      end
      def convert(node, state = {})
        '' # noop
      end
    end

    register :colgroup, Ignore.new
    register :col,      Ignore.new
  end
end
