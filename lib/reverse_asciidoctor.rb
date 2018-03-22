require 'digest'
require 'nokogiri'
require 'reverse_asciidoctor/version'
require 'reverse_asciidoctor/errors'
require 'reverse_asciidoctor/cleaner'
require 'reverse_asciidoctor/config'
require 'reverse_asciidoctor/converters'
require 'reverse_asciidoctor/converters/base'
require 'reverse_asciidoctor/converters/a'
require 'reverse_asciidoctor/converters/aside'
require 'reverse_asciidoctor/converters/audio'
require 'reverse_asciidoctor/converters/blockquote'
require 'reverse_asciidoctor/converters/br'
require 'reverse_asciidoctor/converters/bypass'
require 'reverse_asciidoctor/converters/code'
require 'reverse_asciidoctor/converters/div'
require 'reverse_asciidoctor/converters/drop'
require 'reverse_asciidoctor/converters/em'
require 'reverse_asciidoctor/converters/figure'
require 'reverse_asciidoctor/converters/h'
require 'reverse_asciidoctor/converters/hr'
require 'reverse_asciidoctor/converters/ignore'
require 'reverse_asciidoctor/converters/img'
require 'reverse_asciidoctor/converters/mark'
require 'reverse_asciidoctor/converters/li'
require 'reverse_asciidoctor/converters/ol'
require 'reverse_asciidoctor/converters/p'
require 'reverse_asciidoctor/converters/pass_through'
require 'reverse_asciidoctor/converters/pre'
require 'reverse_asciidoctor/converters/q'
require 'reverse_asciidoctor/converters/strong'
require 'reverse_asciidoctor/converters/table'
require 'reverse_asciidoctor/converters/td'
require 'reverse_asciidoctor/converters/th'
require 'reverse_asciidoctor/converters/text'
require 'reverse_asciidoctor/converters/tr'

module ReverseAsciidoctor

  def self.convert(input, options = {})
    root = case input
      when String                  then Nokogiri::HTML(input).root
      when Nokogiri::XML::Document then input.root
      when Nokogiri::XML::Node     then input
    end

    root or return ''

    config.with(options) do
      result = ReverseAsciidoctor::Converters.lookup(root.name).convert(root)
      cleaner.tidy(result)
    end
  end

  def self.config
    @config ||= Config.new
    yield @config if block_given?
    @config
  end

  def self.cleaner
    @cleaner ||= Cleaner.new
  end

end
