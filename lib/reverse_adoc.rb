# frozen_string_literal: true

require 'digest'
require 'nokogiri'
require 'reverse_adoc/version'
require 'reverse_adoc/errors'
require 'reverse_adoc/cleaner'
require 'reverse_adoc/config'
require 'reverse_adoc/converters'
require 'reverse_adoc/converters/base'

module ReverseAdoc
  def self.convert(input, options = {})
    type = config.input_format
    name = "#{type}_converter"
    require "reverse_adoc/#{type}_converter"
    constant = name.split('_').map(&:capitalize).join.to_s
    ReverseAdoc.const_get(constant).convert(input, options)
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
