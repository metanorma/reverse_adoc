require 'spec_helper'

describe ReverseAsciidoctor::Converters::Br do
  let(:converter) { ReverseAsciidoctor::Converters::Br.new }

  it 'just converts into two spaces and a newline' do
    expect(converter.convert(:anything)).to eq " \+\n"
  end
end
