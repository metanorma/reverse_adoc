require 'spec_helper'

describe ReverseAdoc do

  let(:input)    { File.read('spec/assets/escapables.html') }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  context "multiple asterisks" do
    it { is_expected.to include ' \*\*two asterisks\*\* ' }
    it { is_expected.to include ' \*\*\*three asterisks\*\*\* ' }
    it { is_expected.to include ' \*and*the\* ' }
    it { is_expected.to include ' asterisc*word ' }
    it { is_expected.to include ' asterisc**multword asterisks\*\*\* ' }
  end

  context "multiple underscores" do
    it { is_expected.to include ' \_\_two underscores\_\_ ' }
    it { is_expected.to include ' \_\_\_three underscores\_\_\_ ' }
  end

  context "multiple underscores with undersocre inside words and new lines" do
    it { is_expected.to include 'another_undersocre' }
    it { is_expected.to include ' \_\_\_three__underscores\_\_\_ ' }
  end

  context "underscores within words in code blocks" do
    it { is_expected.to include "....\n<code>var theoretical_max_infin = 1.0;</code>\n....\n" }
  end

end
