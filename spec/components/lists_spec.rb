require "spec_helper"

describe ReverseAdoc do
  let(:input)    { File.read("spec/assets/lists.html") }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  it { is_expected.to match /\n\* unordered list entry\n/ }
  it { is_expected.to match /\n\* unordered list entry 2\n/ }
  it { is_expected.to match /\n. ordered list entry\n/ }
  it { is_expected.to match /\n. ordered list entry 2\n/ }
  it { is_expected.to match /\n. list entry 1st hierarchy\n/ }
  it { is_expected.to match /\n\*\* nested unsorted list entry\n/ }
  it { is_expected.to match /\n\.\.\. deep nested list entry\n/ }

  context "list anchors" do
    it { is_expected.to match /\n\[\[1\]\]\n\. arabic1\n/ }
    it { is_expected.to match /\n\[\[A\]\]\n\* upperalpha1\n/ }
  end

  context "list styles" do
    it { is_expected.to match /\n\[arabic\]\n\. arabic\n/ }
    it { is_expected.to match /\n\[loweralpha\]\n\. loweralpha\n/ }
    it { is_expected.to match /\n\[upperalpha\]\n\. upperalpha\n/ }
    it { is_expected.to match /\n\[lowerroman\]\n\. lowerroman\n/ }
    it { is_expected.to match /\n\[upperroman\]\n\. upperroman\n/ }
    it { is_expected.to match /\n\[type=disc\]\n\* disc\n/ }
  end

  context "list start, reversed" do
    it { is_expected.to match /\n\[start=3\]\n\. another ordered list entry\n/ }
    it {
      is_expected.to match /\n\[%reversed\]\n\. a reversed ordered list entry\n/
    }
  end

  context "nested list with no whitespace" do
    it { is_expected.to match /\n\* item a\n/ }
    it { is_expected.to match /\n\* item b\n/ }
    it { is_expected.to match /\n\*\* item bb\n/ }
    it { is_expected.to match /\n\*\* item bc\n/ }
  end

  context "nested list with lots of whitespace" do
    it { is_expected.to match /\n\* item wa \n/ }
    it { is_expected.to match /\n\* item wb \n/ }
    it { is_expected.to match /\n\*\* item wbb \n/ }
    it { is_expected.to match /\n\*\* item wbc \n/ }
  end

  context "lists containing links" do
    it { is_expected.to match /\n\* link:Basic_concepts\[1 Basic concepts\]\n/ }
    it {
      is_expected.to match /\n\* link:History_of_the_idea\[2 History of the idea\]\n/
    }
    it {
      is_expected.to match /\n\* link:Intelligence_explosion\[3 Intelligence explosion\]\n/
    }
  end

  context "lists containing embedded <p> tags" do
    xit { is_expected.to match /\n\* I want to have a party at my house!\n/ }
  end

  context "list item containing multiple <p> tags" do
    xit { is_expected.to match /\n\* li 1, p 1\n\n\* li 1, p 2\n/ }
  end

  context "it produces correct numbering" do
    it { is_expected.to include "\. one" }
    it { is_expected.to include "\.\. one one" }
    it { is_expected.to include "\.\. one two" }
    it { is_expected.to include "\. two" }
    it { is_expected.to include "\.\. two one" }
    it { is_expected.to include "\.\.\. two one one" }
    it { is_expected.to include "\.\.\. two one two" }
    it { is_expected.to include "\.\. two two" }
    it { is_expected.to include "\. three" }
  end

  context "properly embeds a nested list between adjacent list items" do
    it { is_expected.to match /\n\* alpha\n/ }
    it { is_expected.to match /\n\* bravo/ }
    it { is_expected.to match /\n\*\* bravo alpha\n/ }
    it { is_expected.to match /\n\*\* bravo bravo/ }
    it { is_expected.to match /\n\*\*\* bravo bravo alpha/ }
    it { is_expected.to match /\n\* charlie\n/ }
    it { is_expected.to match /\n\* delta\n/ }
  end
end
