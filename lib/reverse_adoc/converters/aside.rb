module ReverseAdoc
  module Converters
    class Aside < Base
      def convert(node, state = {})
        id = node['id']
        anchor = id ? "[[#{id}]]\n" : ""
        content = treat_children(node, state).strip
        "\n\n****\n" << treat_children(node, state) << "\n****\n\n"
      end
    end

    register :aside, Aside.new
  end
end
