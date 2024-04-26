require "spec_helper"

describe ReverseAdoc::Converters::Video do
  let(:converter) { ReverseAdoc::Converters::Video.new }

  it "converts video with no attributes" do
    node = node_for("<video src='example.mp4'/>")
    expect(converter.convert(node)).to include "video::example.mp4[]"
  end

  it "converts video with full set of attributes" do
    node = node_for("<video id='A' src='example.mp4' loop='loop'/>")
    expect(converter.convert(node)).to include "[[A]]\nvideo::example.mp4[options=\"loop\"]"
  end
end
