require 'spec_helper'

describe ReverseAsciidoctor do
  let(:input)    { File.read('spec/assets/minimum.html') }
  let(:document) { Nokogiri::HTML(input) }

  it 'parses nokogiri documents' do
    expect { ReverseAsciidoctor.convert(document) }.not_to raise_error
  end

  it 'parses nokogiri elements' do
    expect { ReverseAsciidoctor.convert(document.root) }.not_to raise_error
  end

  it 'parses string input' do
    expect { ReverseAsciidoctor.convert(input) }.not_to raise_error
  end

  it 'behaves in a sane way when root element is nil' do
    expect(ReverseAsciidoctor.convert(nil)).to eq ''
  end

  describe '#config' do
    it 'stores a given configuration option' do
      ReverseAsciidoctor.config.tag_border = true
      expect(ReverseAsciidoctor.config.tag_border).to eq true
    end

    it 'can be used as a block configurator as well' do
      ReverseAsciidoctor.config do |config|
        expect(config.tag_border).to eq ' '
        config.tag_border = true
      end
      expect(ReverseAsciidoctor.config.tag_border).to eq true
    end
  end

  shared_examples 'converting source with external images included' do |result|
    let(:temp_dir) do
      Pathname.new(ReverseAsciidoctor.config.destination).dirname
    end
    let(:images_folder) { File.join(temp_dir, 'images') }

    before do
      ReverseAsciidoctor.config.destination = File.join(Dir.mktmpdir,
                                                        'output.html')
      ReverseAsciidoctor.config.sourcedir = Dir.mktmpdir
      ReverseAsciidoctor.config.external_images = true
    end

    after do
      FileUtils.rm_rf(temp_dir)
    end

    it 'Creates local files from external URI' do
      expect { convert }
        .to(change do
          Dir["#{images_folder}/*gif"]
            .map { |entry| File.basename(entry) }
            .sort
        end.from([]).to(result))
    end
  end

  # TODO: fix github actions integration with libreoffice, currently it hangs
  # when trying to use soffice binary
  unless Gem::Platform.local.os == 'darwin' && !ENV['GITHUB_ACTION'].nil?
    context 'when docx file input' do
      subject(:convert) do
        ReverseAsciidoctor.convert(
          ReverseAsciidoctor.cleaner.preprocess_word_html(input.document.html),
          WordToMarkdown::REVERSE_MARKDOWN_OPTIONS
        )
      end
      let(:input) do
        WordToMarkdown.new('spec/assets/external_images.docx',
          ReverseAsciidoctor.config.sourcedir)
      end
      it_behaves_like 'converting source with external images included',
                      ['001.gif', '002.gif']
    end
  end

  context 'when html file input' do
    subject(:convert) { ReverseAsciidoctor.convert(input) }
    let(:input) { File.read('spec/assets/external_images.html') }
    it_behaves_like 'converting source with external images included',
                    ['001.gif']
  end
end
