# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/note'

describe ReverseAsciidoctor::Converters::Note do
  let(:converter) { described_class.new }
  let(:output) do
    <<~TEXT
    [NOTE]
    --
     foo

    --
    TEXT
  end

  it 'converts note` children' do
    input = node_for('<note><li>foo</li></note>')
    expect(converter.convert(input)).to eq(output)
  end
end
