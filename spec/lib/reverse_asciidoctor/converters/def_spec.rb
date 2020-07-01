# frozen_string_literal: true

require 'spec_helper'
require 'reverse_asciidoctor/converters/def'

describe ReverseAsciidoctor::Converters::Def do
  let(:converter) { described_class.new }

  it 'converts def children' do
    input = node_for('<def><li>foo</li></def>')
    expect(converter.convert(input)).to eq " foo\n"
  end
end
