module ReverseAdoc
  module Converters
    class Bypass < Base
      def to_coradoc(node, state = {})
        treat_children_coradoc(node, state)
      end

      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :document, Bypass.new
    register :html,     Bypass.new
    register :body,     Bypass.new
    register :span,     Bypass.new
    register :thead,    Bypass.new
    register :tbody,    Bypass.new
    register :tfoot,    Bypass.new
    register :abbr, Bypass.new
    register :acronym,    Bypass.new
    register :address,    Bypass.new
    register :applet, Bypass.new
    register :map, Bypass.new
    register :area, Bypass.new
    register :bdi,    Bypass.new
    register :bdo,    Bypass.new
    register :big,    Bypass.new
    register :button,    Bypass.new
    register :canvas,    Bypass.new
    register :data, Bypass.new
    register :datalist, Bypass.new
    register :del,    Bypass.new
    register :ins,    Bypass.new
    register :dfn,    Bypass.new
    register :dialog, Bypass.new
    register :embed, Bypass.new
    register :fieldset, Bypass.new
    register :font, Bypass.new
    register :footer, Bypass.new
    register :form, Bypass.new
    register :frame, Bypass.new
    register :frameset, Bypass.new
    register :header,    Bypass.new
    register :iframe,    Bypass.new
    register :input,    Bypass.new
    register :label,    Bypass.new
    register :legend, Bypass.new
    register :main,    Bypass.new
    register :menu,    Bypass.new
    register :menulist, Bypass.new
    register :meter, Bypass.new
    register :nav, Bypass.new
    register :noframes,    Bypass.new
    register :noscript,    Bypass.new
    register :object, Bypass.new
    register :optgroup, Bypass.new
    register :option,    Bypass.new
    register :output,    Bypass.new
    register :param, Bypass.new
    register :picture, Bypass.new
    register :progress, Bypass.new
    register :ruby, Bypass.new
    register :rt,    Bypass.new
    register :rp,    Bypass.new
    register :s, Bypass.new
    register :select, Bypass.new
    register :small, Bypass.new
    register :span, Bypass.new
    register :strike, Bypass.new
    register :details,    Bypass.new
    register :section,    Bypass.new
    register :summary,    Bypass.new
    register :svg, Bypass.new
    register :template,    Bypass.new
    register :textarea,    Bypass.new
    register :track, Bypass.new
    register :u, Bypass.new
    register :wbr, Bypass.new
  end
end
