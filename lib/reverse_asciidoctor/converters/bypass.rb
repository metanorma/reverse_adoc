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
    register :bdi,    Bypass.new
    register :bdo,    Bypass.new
    register :big,    Bypass.new
    register :button,    Bypass.new
    register :canvas,    Bypass.new
    register :data,    Bypass.new
    register :datalist,    Bypass.new
    register :del,    Bypass.new
    register :ins,    Bypass.new
    register :dfn,    Bypass.new
    register :dialog,    Bypass.new
    register :embed,    Bypass.new
    register :fieldset,    Bypass.new
    register :font,    Bypass.new
    register :footer,    Bypass.new
    register :form,    Bypass.new
    register :frame,    Bypass.new
    register :frameset,    Bypass.new
    register :header,    Bypass.new
    register :iframe,    Bypass.new
    register :input,    Bypass.new
    register :label,    Bypass.new
    register :legend,    Bypass.new
    register :main,    Bypass.new
    register :menu,    Bypass.new
    register :menulist,    Bypass.new
    register :meter,    Bypass.new
    register :nav,    Bypass.new
    register :noframes,    Bypass.new
    register :script,    Bypass.new
    register :noscript,    Bypass.new
    register :object,    Bypass.new
  end
end
