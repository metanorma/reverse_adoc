require 'spec_helper'

describe ReverseAsciidoctor::Converters::Head do
  it 'starts document with a title' do
    input = "<html><head><link>B</link> <style>?</style> <title>Title</title> <link>X</link> </head> <body><p>Para</p></body></html>"
    result = ReverseAsciidoctor.convert(input)
    expect(result).to eq "= Title\n\nPara\n\n"
  end

  it 'starts document without a title' do
    input = "<html><head><link>Title</link></head><body><p>Para</p></body></html>"
    result = ReverseAsciidoctor.convert(input)
    expect(result).to eq "= (???)\n\nPara\n\n"
  end
end
