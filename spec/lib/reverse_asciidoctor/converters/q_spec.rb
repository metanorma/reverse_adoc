require 'spec_helper'

describe ReverseAsciidoctor::Converters::Q do
  let(:converter) { ReverseAsciidoctor::Converters::Q.new }

  it 'renders q' do
    input = node_for('<q>A</q>')
    expect(converter.convert(input)).to eq '"A"'
  end
end
