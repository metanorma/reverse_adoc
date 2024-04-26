require "spec_helper"

describe ReverseAdoc::Converters::Img do
  let(:converter) { ReverseAdoc::Converters::Img.new }

  it "converts image with no attributes" do
    node = node_for("<img src='example.jpg'/>")
    expect(converter.convert(node)).to include "image::example.jpg[]"
  end

  it "converts image with full set of attributes" do
    node = node_for("<img id='A' alt='Alt Text' src='example.jpg' width='30' height='40'/>")
    expect(converter.convert(node)).to include "[[A]]\nimage::example.jpg[Alt Text,30,40]"
  end

  it "converts image with alt text, no width and height" do
    node = node_for("<img id='A' alt='Alt Text' src='example.jpg'/>")
    expect(converter.convert(node)).to include "[[A]]\nimage::example.jpg[Alt Text]"
  end

  it "converts image with width and height, no alt text" do
    node = node_for("<img id='A' src='example.jpg' width='30' height='40'/>")
    expect(converter.convert(node)).to include "[[A]]\nimage::example.jpg[\"\",30,40]"
  end
end
