require 'spec_helper'

describe ReverseAsciidoctor::Converters do
  before { ReverseAsciidoctor.config.unknown_tags = :raise }
  let(:converters) { ReverseAsciidoctor::Converters }

  describe '.register and .unregister' do
    it 'adds a converter mapping to the list' do
      expect { converters.lookup(:foo) }.to raise_error ReverseAsciidoctor::UnknownTagError

      converters.register :foo, :foobar
      expect(converters.lookup(:foo)).to eq :foobar

      converters.unregister :foo
      expect { converters.lookup(:foo) }.to raise_error ReverseAsciidoctor::UnknownTagError
    end
  end

end
