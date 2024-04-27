module ReverseAdoc
  class Cleaner
    def tidy(string)
      result = remove_inner_whitespaces(String.new(string))
      result = remove_newlines(result)
      result = remove_leading_newlines(result)
      result = clean_tag_borders(result)
      clean_punctuation_characters(result)
    end

    def remove_newlines(string)
      string.gsub(/\n{3,}/, "\n\n")
    end

    def remove_leading_newlines(string)
      string.gsub(/\A\n+/, "")
    end

    def remove_inner_whitespaces(string)
      unless string.nil?
        string.gsub!(/\n stem:\[/, "\nstem:[")
        string.gsub!(/(stem:\[([^\]]|\\\])*\])\n(?=\S)/, "\\1 ")
        string.gsub!(/(stem:\[([^\]]|\\\])*\])\s+(?=[\^-])/, "\\1")
      end
      string.each_line.inject("") do |memo, line|
        memo + preserve_border_whitespaces(line) do
          line.strip.gsub(/[ \t]{2,}/, " ")
        end
      end
    end

    # Find non-asterisk content that is enclosed by two or
    # more asterisks. Ensure that only one whitespace occurs
    # in the border area.
    # Same for underscores and brackets.
    def clean_tag_borders(string)
      # result = string.gsub(/\s?\*{2,}.*?\*{2,}\s?/) do |match|
      # preserve_border_whitespaces(match, default_border: ReverseAdoc.config.tag_border) do
      #   match.strip.sub("** ", "**").sub(" **", "**")
      # end
      # end

      # result = string.gsub(/\s?_{2,}.*?_{2,}\s?/) do |match|
      #   preserve_border_whitespaces(match, default_border: ReverseAdoc.config.tag_border) do
      #     match.strip.sub("__ ", "__").sub(" __", "__")
      #   end
      # end

      result = string.gsub(/\s?~{2,}.*?~{2,}\s?/) do |match|
        preserve_border_whitespaces(match,
                                    default_border: ReverseAdoc.config.tag_border) do
          match.strip.sub("~~ ", "~~").sub(" ~~", "~~")
        end
      end

      result.gsub(/\s?\[.*?\]\s?/) do |match|
        preserve_border_whitespaces(match) do
          match.strip.sub("[ ", "[").sub(" ]", "]")
        end
      end
    end

    def clean_punctuation_characters(string)
      string.gsub(/(\*\*|~~|__)\s([.!?'"])/, "#{'\\1'.strip}\\2")
    end

    # preprocesses HTML, rather than postprocessing it
    def preprocess_word_html(string)
      clean_headings(scrub_whitespace(string.dup))
    end

    def scrub_whitespace(string)
      string.gsub!(/&nbsp;|&#xA0;|\u00a0/i, "&#xA0;") # HTML encoded spaces
      string.sub!(/^\A[[:space:]]+/m, "") # document leading whitespace
      string.sub!(/[[:space:]]+\z$/m, "") # document trailing whitespace
      string.gsub!(/( +)$/, " ") # line trailing whitespace
      string.gsub!(/\n\n\n\n/, "\n\n") # Quadruple line breaks
      # string.delete!('?| ')               # Unicode non-breaking spaces, injected as tabs
      string
    end

    # following added by me
    def clean_headings(string)
      string.gsub!(%r{<h([1-9])[^>]*></h\1>}, " ")
      # I don't know why Libre Office is inserting them, but they need to go
      string.gsub!(%r{<h([1-9])[^>]* style="vertical-align: super;[^>]*>(.+?)</h\1>},
                   "<sup>\\2</sup>")
      # I absolutely don't know why Libre Office is rendering superscripts as h1
      string
    end

    private

    def preserve_border_whitespaces(string, options = {})
      return string if /\A\s*\Z/.match?(string)

      default_border = options.fetch(:default_border, "")
      # If the string contains part of a link so the characters [,],(,)
      # then don't add any extra spaces
      default_border = "" if /[\[(\])]/.match?(string)
      string_start   = present_or_default(string[/\A\s*/], default_border)
      string_end     = present_or_default(string[/\s*\Z/], default_border)
      result         = yield
      string_start + result + string_end
    end

    def present_or_default(string, default)
      return default if string.nil? || string.empty?

      string
    end
  end
end
