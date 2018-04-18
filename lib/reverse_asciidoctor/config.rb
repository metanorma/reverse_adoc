module ReverseAsciidoctor
  class Config
    attr_accessor :unknown_tags, :tag_border, :mathml2asciimath

    def initialize
      @unknown_tags     = :pass_through
      @mathml2asciimath     = false
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

    def mathml2asciimath
      @inline_options[:mathml2asciimath] || @mathml2asciimath
    end

    def tag_border
      @inline_options[:tag_border] || @tag_border
    end
  end
end
