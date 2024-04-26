require "spec_helper"

describe ReverseAdoc::Config do
  describe "#with" do
    let(:config) { ReverseAdoc.config }

    it "takes additional options into account" do
      config.with(tag_border: :foobar) do
        expect(ReverseAdoc.config.tag_border).to eq :foobar
      end
    end

    it "returns the result of a given block" do
      expect(config.with { :something }).to eq :something
    end

    it "resets to original settings afterwards" do
      config.tag_border = :foo
      config.with(tag_border: :bar) do
        expect(ReverseAdoc.config.tag_border).to eq :bar
      end
      expect(ReverseAdoc.config.tag_border).to eq :foo
    end
  end
end
