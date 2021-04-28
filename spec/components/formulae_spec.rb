require "spec_helper"

describe ReverseAdoc do

  let(:input)    { File.read("spec/assets/formulae.html") }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  before { ReverseAdoc.config.mathml2asciimath = true }

  it { is_expected.to include("stem:[E = m c^2]").twice }
  # would be prettier without that space after "x"
  it { is_expected.to include('stem:[\[x \]]') }
  it { is_expected.to include("The admirable number stem:[Pi]") }
end
