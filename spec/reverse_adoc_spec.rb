# frozen_string_literal: true

require "reverse_adoc"

RSpec.describe ReverseAdoc do
  # Inline formatting (<b>/<i>) is currently dropped by ceradoc-html's
  # html→asciidoc path (1.1.25 registers :b on monorepo main only), so
  # these specs assert the surface that converts today: blocks, links,
  # and plain text.
  it "converts headings" do
    expect(described_class.convert("<h1>Hello</h1>")).to include("= Hello")
  end

  it "converts paragraph text" do
    expect(described_class.convert("<p>plain paragraph text</p>"))
      .to include("plain paragraph text")
  end

  it "converts links" do
    expect(described_class.convert("<p>a <a href=\"http://x.example\">link</a></p>"))
      .to include("http://x.example[link]")
  end

  it "accepts and ignores a legacy options hash for arity compatibility" do
    expect(described_class.convert("<h1>Hello</h1>", unknown_tags: :raise))
      .to eq(described_class.convert("<h1>Hello</h1>"))
  end
end
