require 'spec_helper'

describe ReverseAsciidoctor do

  let(:input)    { File.read('spec/assets/anchors.html') }
  let(:document) { Nokogiri::HTML(input) }
  puts ReverseAsciidoctor.convert(File.read('spec/assets/anchors.html'))
  subject { ReverseAsciidoctor.convert(input) }

  it { is_expected.to include 'http://foobar.com[Foobar]' }
  it { is_expected.to include 'http://foobar.com[Fubar]' }
  it { is_expected.to include 'http://foobar.com[f\*\*\*\*\* up beyond all redemption]' }
  it { is_expected.to include 'http://strong.foobar.com[*Strong foobar*]' }

  it { is_expected.to include 'There should be space before but not after the anchor ( http://foobar.com[stripped]).' }

  it { is_expected.to include ' do not ignore link:foo.html[] anchor tags with no link text ' }
  it { is_expected.to include ' link <<content,internal jumplinks>> with anchors ' }
  it { is_expected.to include ' link <<content2>>internal jumplinks without anchors ' }
  it { is_expected.to include ' treat [[content]] as bookmarks ' }

end
