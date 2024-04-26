require "spec_helper"

describe ReverseAdoc::Converters::Q do
  let(:converter) { ReverseAdoc::Converters::Q.new }

  it "renders q" do
    input = node_for("<q>A</q>")
    expect(converter.convert(input)).to eq '"A"'
  end
end
