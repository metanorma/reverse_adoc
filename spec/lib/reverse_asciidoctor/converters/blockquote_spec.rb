require 'spec_helper'

describe ReverseAsciidoctor::Converters::Blockquote do

  let(:converter) { ReverseAsciidoctor::Converters::Blockquote.new }

  it 'converts nested elements as well' do
    input = node_for("<blockquote><ul><li>foo</li></ul></blockquote>")
    result = converter.convert(input)
    expect(result).to eq "\n\n____\n* foo\n____\n\n"
  end

  it 'can deal with paragraphs inside' do
    input = node_for("<blockquote><p>Some text.</p><p>Some more text.</p></blockquote>")
    result = converter.convert(input)
    expect(result).to eq "\n\n____\nSome text.\n\nSome more text.\n____\n\n"
  end
end
