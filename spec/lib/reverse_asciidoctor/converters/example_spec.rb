# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/example'

describe ReverseAsciidoctor::Converters::Example do
  let(:converter) { described_class.new }
  let(:output) do
    <<~TEXT
    [example]
    ====
     foo

    ====
    TEXT
  end

  it 'converts example` children' do
    input = node_for('<example><li>foo</li></example>')
    expect(converter.convert(input)).to eq(output)
  end
end
