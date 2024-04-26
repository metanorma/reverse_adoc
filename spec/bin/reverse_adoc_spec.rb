# frozen_string_literal: true

require "spec_helper"

describe "exe/reverse_adoc" do
  subject(:convert) do
    ShellUtils.execute!("./exe/reverse_adoc -e -o test1 #{input_file_path}")
  end

  unless Gem.win_platform?
    context "when external images present" do
      let(:input_file_path) { "spec/assets/external_images.html" }
      let(:images_folder) { "images" }

      after do
        FileUtils.rm_rf(images_folder) if File.directory?(images_folder)
      end

      it "Does not raise error" do
        expect { convert }.to_not raise_error
      end

      it "exatracts images from source html" do
        expect { convert }
          .to(change do
            Dir["#{images_folder}/*gif"]
              .map { |entry| File.basename(entry) }
              .sort
          end.from([]).to(["001.gif"]))
      end
    end
  end
end
