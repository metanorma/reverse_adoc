require "spec_helper"

describe ReverseAdoc do
  let(:input)    { File.read("spec/assets/tables.html") }
  let(:document) { Nokogiri::HTML(input) }
  subject { ReverseAdoc.convert(input) }

  it {
    is_expected.to match /\[\[A\]\]\n\|===\n\| \[\[C\]\]header 1 \| header 2 \| header 3\n\n/
  }
  it {
    is_expected.to match /\nh\| \[\[D\]\]data 1-1 \| data 2-1 \| data 3-1\n/
  }
  it { is_expected.to match /\nh\| data 1-2 \| data 2-2 \| data 3-2\n/ }

  it {
    is_expected.to match /\n\| _header oblique_ \| \*header bold\* \| `header code`\n\n/
  }
  it {
    is_expected.to match /\n\| _data oblique_ \| \*data bold\* \| `data code`\n/
  }

  it { is_expected.to match /\n\.2\+\| rowspan 2\n/ }
  it { is_expected.to match /\n2\+| colspan 2\n/ }
  it { is_expected.to match /\n2\.2\+| colrowspan 2\n/ }

  it { is_expected.to match /<\| horizontal left / }
  it { is_expected.to match /\^\| horizontal center / }
  it { is_expected.to match />\| horizontal right\n/ }
  it { is_expected.to match /\^\.\^\| center middle\n/ }

  it { is_expected.to match /\n\.Table _caption_\n\|===\n/ }
  # it { is_expected.to match /\n\[width=75%\]\n\|===\n\| 75% width table\n/ }
  it {
    is_expected.to match /\n\[frame=topbot,rules=cols\]\n\|===\n\| topbot\n/
  }

  it {
    is_expected.to match /\na|\nHello\n\nThis cell has multiple paragraphs\n\n/
  }
  it { is_expected.to match /\n\| This cell has a single paragraph\n/ }
end
