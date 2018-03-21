require 'spec_helper'

describe ReverseAsciidoctor do

  let(:input)    { File.read('spec/assets/quotation.html') }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAsciidoctor.convert(input) }

  it { is_expected.to match /\n      <code>Block of code<\/code>$/ }
  it { is_expected.to include "\n> First quoted paragraph\n> \n> Second quoted paragraph" }

end
