# frozen_string_literal: true

require 'digest'
require 'nokogiri'
require 'reverse_asciidoctor/version'
require 'reverse_asciidoctor/errors'
require 'reverse_asciidoctor/cleaner'
require 'reverse_asciidoctor/config'
require 'reverse_asciidoctor/converters'
require 'reverse_asciidoctor/converters/base'

module ReverseAsciidoctor
  def self.convert(input, options = {})
    type = config.input_format
    name = "#{type}_converter"
    require "reverse_asciidoctor/#{type}_converter"
    constant = name.split('_').map(&:capitalize).join.to_s
    ReverseAsciidoctor.const_get(constant).convert(input, options)
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
