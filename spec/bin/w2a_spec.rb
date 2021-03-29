# frozen_string_literal: true

require 'spec_helper'

describe 'bin/w2a' do
  subject(:convert) do
    ShellUtils.execute!("./bin/w2a -e -o test1 #{input_file_path}")
  end
  # TODO: fix github actions integration with libreoffice, currently it hangs
  # when trying to use soffice binary
  unless Gem.win_platform? ||
         (Gem::Platform.local.os == 'darwin' && !ENV['GITHUB_ACTION'].nil?)
    context 'when external images present' do
      let(:input_file_path) { 'spec/assets/external_images.docx' }
      let(:images_folder) { 'images' }

      after do
        FileUtils.rm_rf(images_folder) if File.directory?(images_folder)
      end

      it 'Does not raise error' do
        expect { convert }.to_not raise_error
      end

      it 'extracts images from source html' do
        expect { convert }
          .to(change do
            Dir["#{images_folder}/*gif"]
              .map { |entry| File.basename(entry) }
              .sort
          end.from([]).to(['001.gif']))
      end
    end
  end
end
