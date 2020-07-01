# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/definition'

describe ReverseAsciidoctor::Converters::Definition do
  let(:converter) { described_class.new }

  it 'converts definition children' do
    input = node_for('<definition><li>foo</li></definition>')
    expect(converter.convert(input)).to eq " foo\n"
  end
end
