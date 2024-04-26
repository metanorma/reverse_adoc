require "tmpdir"

module ReverseAdoc
  class Config
    attr_accessor :unknown_tags, :tag_border, :mathml2asciimath, :external_images,
                  :destination, :sourcedir, :image_counter, :image_counter_pattern, :input_format

    def initialize
      @unknown_tags     = :pass_through
      @input_format     = :html
      @mathml2asciimath = false
      @external_images  = false

      # Destination to save file and images
      @destination      = nil

      # Source of HTML
      # @sourcedir        = nil

      # Image counter, assuming there are max 999 images
      @image_counter = 1
      # pad with 0s
      @image_counter_pattern = "%03d"

      @em_delimiter     = "_".freeze
      @strong_delimiter = "*".freeze
      @inline_options   = {}
      @tag_border       = " ".freeze
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

    def external_images
      @inline_options[:external_images] || @external_images
    end

    def tag_border
      @inline_options[:tag_border] || @tag_border
    end
  end
end
