require "spec_helper"

describe ReverseAdoc do
  let(:input)    { File.read("spec/assets/unknown_tags.html") }
  let(:document) { Nokogiri::HTML(input) }
  let(:result)   { ReverseAdoc.convert(input) }

  context "with unknown_tags = :pass_through" do
    before { ReverseAdoc.config.unknown_tags = :pass_through }

    it { expect(result).to include "<bar>Foo with bar</bar>" }
  end

  context "with unknown_tags = :raise" do
    before { ReverseAdoc.config.unknown_tags = :raise }

    it { expect { result }.to raise_error(ReverseAdoc::UnknownTagError) }
  end

  context "with unknown_tags = :drop" do
    before { ReverseAdoc.config.unknown_tags = :drop }

    it { expect(result).to eq "" }
  end

  context "with unknown_tags = :bypass" do
    before { ReverseAdoc.config.unknown_tags = :bypass }

    it { expect(result).to eq "Foo with bar\n\n" }
  end

  context "with unknown_tags = :something_wrong" do
    before { ReverseAdoc.config.unknown_tags = :something_wrong }

    it {
      expect do
        result
      end.to raise_error(ReverseAdoc::InvalidConfigurationError)
    }
  end
end
