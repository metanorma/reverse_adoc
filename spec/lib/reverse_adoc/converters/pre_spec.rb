require "spec_helper"

describe ReverseAdoc::Converters::Pre do
  let(:converter) { ReverseAdoc::Converters::Pre.new }

  it "converts as literal" do
    node = node_for("<pre>puts foo</pre>")
    expect(converter.convert(node)).to include "....\nputs foo\n....\n"
  end

  it "converts as literal with anchor" do
    node = node_for("<pre id='A'>puts foo</pre>")
    expect(converter.convert(node)).to include "[[A]]\n....\nputs foo\n....\n"
  end

  it "preserves new lines" do
    node = node_for("<pre>foo\nbar</pre>")
    expect(converter.convert(node)).to include "....\nfoo\nbar\n....\n"
  end

  it "preserves xml" do
    node = node_for("<pre><code>x</code><br/><p>hello</p></pre>")
    expect(converter.convert(node)).to include "....\nx\n\n\nhello\n\n\n....\n"
  end

  context "syntax highlighting" do
    it 'works for "highlight-lang" mechanism' do
      div = node_for("<div class='highlight highlight-ruby'><pre>puts foo</pre></div>")
      pre = div.children.first
      expect(converter.convert(pre)).to include "[source,ruby]\n----\nputs foo\n----\n"
    end

    it "works for the confluence mechanism" do
      pre = node_for("<pre class='theme: Confluence; brush: html/xml; gutter: false'>puts foo</pre>")
      expect(converter.convert(pre)).to include "[source,html/xml]\n----\nputs foo\n----\n"
    end

    it "works for the confluence mechanism, with anchor" do
      pre = node_for("<pre id = 'A' class='theme: Confluence; brush: html/xml; gutter: false'>puts foo</pre>")
      expect(converter.convert(pre)).to include "[[A]]\n[source,html/xml]\n----\nputs foo\n----\n"
    end
  end
end
