# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/ext_descriptions'

describe ReverseAsciidoctor::Converters::ExtDescriptions do
  let(:converter) { described_class.new }

  it 'converts ext_descriptions children' do
    input = node_for('<ext_descriptions><li>foo</li></ext_descriptions>')
    expect(converter.convert(input)).to eq " foo\n"
  end
end
