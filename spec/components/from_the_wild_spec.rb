require "spec_helper"

describe ReverseAdoc do
  let(:input)    { File.read("spec/assets/from_the_wild.html") }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  it "should make sense of strong-crazy markup (as seen in the wild)" do
    expect(subject).to include "*. +\n \\*\\*\\* intentcast* : logo design *+*\n"
  end

  it "should not over escape * or _" do
    expect(subject).to include 'link:example.com/foo_bar[image::example.com/foo_bar.png[] I\_AM\_HELPFUL]'
  end
end
