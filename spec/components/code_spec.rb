require 'spec_helper'

describe ReverseAdoc do

  let(:input)    { File.read('spec/assets/code.html') }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  it { is_expected.to match /inline `code` block/ }
  it { is_expected.to match /\n<code>var this\;\nthis\.is/ }
  it { is_expected.to match /block"\)\nconsole/ }

  context "with github style code blocks" do
    subject { ReverseAdoc.convert(input) }
    it { is_expected.to match /inline `code` block/ }
    it { is_expected.to match /\n\.\.\.\.\n<code>var this\;\nthis/ }
    it { is_expected.to match /it is"\) ?\n	<\/code>\n\.\.\.\./ }
  end

  context "code with indentation" do
    subject { ReverseAdoc.convert(input) }
    it { is_expected.to match(/^<code>tell application "Foo"\n/) }
    it { is_expected.to match(/^    beep\n/) }
    it { is_expected.to match(/^end tell\n/) }
  end

end

