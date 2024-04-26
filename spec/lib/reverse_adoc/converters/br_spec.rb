require "spec_helper"

describe ReverseAdoc::Converters::Br do
  let(:converter) { ReverseAdoc::Converters::Br.new }

  it "just converts into two spaces and a newline" do
    expect(converter.convert(:anything)).to eq " \+\n"
  end
end
