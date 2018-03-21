module ReverseAsciidoctor
  class Config
    attr_accessor :unknown_tags, :tag_border

    def initialize
      @unknown_tags     = :pass_through
      @em_delimiter     = '_'.freeze
      @strong_delimiter = '*'.freeze
      @inline_options   = {}
      @tag_border       = ' '.freeze
    end

    def with(options = {})
      @inline_options = options
      result = yield
      @inline_options = {}
      result
    end

    def unknown_tags
      @inline_options[:unknown_tags] || @unknown_tags
    end

    def tag_border
      @inline_options[:tag_border] || @tag_border
    end
  end
end
