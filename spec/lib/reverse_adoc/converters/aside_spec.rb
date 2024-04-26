require "spec_helper"

describe ReverseAdoc::Converters::Aside do
  let(:converter) { ReverseAdoc::Converters::Aside.new }

  it "converts aside" do
    input = node_for("<aside><ul><li>foo</li></ul></aside>")
    result = converter.convert(input)
    expect(result).to eq "\n\n\*\*\*\*\n\n* foo\n\n\*\*\*\*\n\n"
  end
end
