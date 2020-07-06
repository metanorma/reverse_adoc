module ReverseAdoc
  module Converters
    class P < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        if state[:tdsinglepara]
          "#{anchor}" << treat_children(node, state).strip
        else
          "\n\n#{anchor}" << treat_children(node, state).strip << "\n\n"
        end
      end
    end

    register :p, P.new
  end
end
