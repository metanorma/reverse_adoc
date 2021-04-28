require "spec_helper"

describe ReverseAdoc::Converters::Math do
  let(:converter) { ReverseAdoc::Converters::Math.new }

  # let(:input) { node_for("<math>#{x_plus_y_mathml}</math>") }
  let(:x_plus_y_mathml) { "<math><mi>x</mi><mo>+</mo><mi>y</mi></math>" }
  let(:mathml_with_line_breaks) { "<math>\n<mn>2</mn>\n<mi>a</mi>\n</math>" }
  let(:mathml_with_brackets) { "<math><mo>[</mo><mi>x</mi><mo>]</mo></math>" }

  context "when conversion to AsciiMath is enabled" do
    before { ReverseAdoc.config.mathml2asciimath = true }

    it "renders a space delimited stem macro with proper AsciiMath" do
      input = node_for(x_plus_y_mathml)
      output = converter.convert(input)
      expect(output).to eq(" stem:[x + y] ")
    end

    it "removes unnecessary line breaks" do
      input = node_for(mathml_with_line_breaks)
      output = converter.convert(input)
      expect(output).to include("stem:[2 a]") # in one line
      expect(output).not_to include("\n")
    end

    it "escapes square brackets" do
      input = node_for(mathml_with_brackets)
      output = converter.convert(input)
      expect(output).to include('stem:[\[ x \]]') # brackets preceded with "\"
    end
  end

  context "when conversion to AsciiMath is disabled" do
    before { ReverseAdoc.config.mathml2asciimath = false }

    it "renders a space delimited stem macro with MathML inside" do
      input = node_for(x_plus_y_mathml)
      output = converter.convert(input)
      expect(output).to eq(" stem:[#{x_plus_y_mathml}] ")
    end

    it "removes unnecessary line breaks" do
      input = node_for(mathml_with_line_breaks)
      output = converter.convert(input)
      expect(output).to match /stem.*<math>.*<mn>2.*<mi>a/
      expect(output).not_to include("\n")
    end

    it "escapes square brackets" do
      input = node_for(mathml_with_brackets)
      output = converter.convert(input)
      # brackets from formula are preceded with "\"
      expect(output).to include('<mo>\[</mo>', '<mo>\]</mo>')
      # brackets delimiting stem macro are not escaped
      expect(output).to include('stem:[')
    end
  end
end
