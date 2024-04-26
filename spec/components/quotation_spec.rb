require "spec_helper"

describe ReverseAdoc do
  let(:input)    { File.read("spec/assets/quotation.html") }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  it { is_expected.to match /\n      Block of code$/ }
  it {
    is_expected.to include "\n____\nFirst quoted paragraph\n\nSecond quoted paragraph\n____\n"
  }
end
