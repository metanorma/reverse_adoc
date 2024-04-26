require "spec_helper"

describe ReverseAdoc::Converters::Figure do
  let(:converter) { ReverseAdoc::Converters::Figure.new }

  it "converts figure" do
    node = node_for("<figure id='A'><img src='example.jpg'/><figcaption>Figure <i>caption</i></figcaption></figure>")
    expect(converter.convert(node)).to include "[[A]]\n.Figure _caption_\n====\nimage::example.jpg[]\n====\n"
  end
end
