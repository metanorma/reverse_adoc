require 'spec_helper'

describe ReverseAsciidoctor::Converters::Mark do
  let(:converter) { ReverseAsciidoctor::Converters::Mark.new }

  it 'renders mark' do
    input = node_for('<mark>A</mark>')
    expect(converter.convert(input)).to eq '#A#'
  end
end
