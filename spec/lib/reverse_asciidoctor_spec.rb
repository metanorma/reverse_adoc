require 'spec_helper'

describe ReverseAsciidoctor do
  let(:input)    { File.read('spec/assets/minimum.html') }
  let(:document) { Nokogiri::HTML(input) }

  it "parses nokogiri documents" do
    expect { ReverseAsciidoctor.convert(document) }.not_to raise_error
  end

  it "parses nokogiri elements" do
    expect { ReverseAsciidoctor.convert(document.root) }.not_to raise_error
  end

  it "parses string input" do
    expect { ReverseAsciidoctor.convert(input) }.not_to raise_error
  end

  it "behaves in a sane way when root element is nil" do
    expect(ReverseAsciidoctor.convert(nil)).to eq ''
  end

  describe '#config' do
    it 'stores a given configuration option' do
      ReverseAsciidoctor.config.tag_border = true
      expect(ReverseAsciidoctor.config.tag_border).to eq true
    end

    it 'can be used as a block configurator as well' do
      ReverseAsciidoctor.config do |config|
        expect(config.tag_border).to eq " "
        config.tag_border = true
      end
      expect(ReverseAsciidoctor.config.tag_border).to eq true
    end
  end
end
