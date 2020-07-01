# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/synonym'

describe ReverseAsciidoctor::Converters::Synonym do
  let(:converter) { described_class.new }

  it 'converts synonym tag by rules' do
    input = node_for('<synonym>foo</synonym>')
    expect(converter.convert(input)).to eq("alt:[foo]")
  end
end
