module ReverseAsciidoctor
  module Converters
    class Bypass < Base
      def convert(node, state = {})
        treat_children(node, state)
      end
    end

    register :document, Bypass.new
    register :html,     Bypass.new
    register :body,     Bypass.new
    register :span,     Bypass.new
    register :thead,    Bypass.new
    register :tbody,    Bypass.new
    register :tfoot,    Bypass.new
    register :abbr,    Bypass.new
    register :acronym,    Bypass.new
    register :address,    Bypass.new
    register :applet,    Bypass.new
    register :map,    Bypass.new
    register :area,    Bypass.new
  end
end
