# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/term'

describe ReverseAsciidoctor::Converters::Term do
  let(:converter) { described_class.new }

  it 'converts term tag by rules' do
    input = node_for('<term>foo</term>')
    expect(converter.convert(input)).to eq("=== foo")
  end
end
