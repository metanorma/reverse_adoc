# frozen_string_literal: true

require 'digest'
require 'nokogiri'
require 'reverse_adoc/version'
require 'reverse_adoc/errors'
require 'reverse_adoc/cleaner'
require 'reverse_adoc/config'
require 'reverse_adoc/converters'
require 'reverse_adoc/converters/base'
require "reverse_adoc/html_converter"

module ReverseAdoc
  def self.convert(input, options = {})
    ReverseAdoc::HtmlConverter.convert(input, options)
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
