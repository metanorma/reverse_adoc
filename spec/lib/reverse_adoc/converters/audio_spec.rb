require "spec_helper"

describe ReverseAdoc::Converters::Audio do
  let(:converter) { ReverseAdoc::Converters::Audio.new }

  it "converts audio with no attributes" do
    node = node_for("<audio src='example.mp3'/>")
    expect(converter.convert(node)).to include "audio::example.mp3[]"
  end

  it "converts audio with full set of attributes" do
    node = node_for("<audio id='A' src='example.mp3' loop='loop'/>")
    expect(converter.convert(node)).to include "[[A]]\naudio::example.mp3[options=\"loop\"]"
  end
end
