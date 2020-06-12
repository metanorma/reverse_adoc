# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/express_ref'

describe ReverseAsciidoctor::Converters::ExpressRef do
  let(:converter) { described_class.new }
  let(:schema) { 'schema' }

  it 'converts supplied tag by format' do
    input = node_for("<express_ref linkend='#{schema}' />")
    expect(converter.convert(input)).to eq("express_ref:[#{schema}]")
  end
end
