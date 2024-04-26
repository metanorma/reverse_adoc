require "spec_helper"

describe ReverseAdoc::Converters::Code do
  let(:converter) { ReverseAdoc::Converters::Div.new }

  it "converts div" do
    node = node_for("<div>puts foo</div>")
    expect(converter.convert(node)).to include "\nputs foo"
  end

  it "converts div with anchor" do
    node = node_for("<div id='A'>puts foo</div>")
    expect(converter.convert(node)).to include "\n[[A]]\nputs foo"
  end
end
