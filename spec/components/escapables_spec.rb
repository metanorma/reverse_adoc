require 'spec_helper'

describe ReverseAsciidoctor do

  let(:input)    { File.read('spec/assets/escapables.html') }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAsciidoctor.convert(input) }

  context "multiple asterisks" do
    it { is_expected.to include ' \*\*two asterisks\*\* ' }
    it { is_expected.to include ' \*\*\*three asterisks\*\*\* ' }
  end

  context "multiple underscores" do
    it { is_expected.to include ' \_\_two underscores\_\_ ' }
    it { is_expected.to include ' \_\_\_three underscores\_\_\_ ' }
  end

  context "underscores within words in code blocks" do
    it { is_expected.to include "....\n<code>var theoretical_max_infin = 1.0;</code>\n....\n" }
  end

end
