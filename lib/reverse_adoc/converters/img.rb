require "fileutils"
require "pathname"
require "tempfile"
require "base64"
require "marcel"

module ReverseAdoc
  module Converters
    class Img < Base

      def image_number
        sprintf(
          ReverseAdoc.config.image_counter_pattern,
          ReverseAdoc.config.image_counter
        )
      end

      def image_number_increment
        ReverseAdoc.config.image_counter += 1
      end

      def datauri2file(src)
        %r{^data:image/(?<imgtype>[^;]+);base64,(?<imgdata>.+)$} =~ src

        dest_dir = Pathname.new(ReverseAdoc.config.destination).dirname
        images_dir = dest_dir + 'images'
        FileUtils.mkdir_p(images_dir)

        ext, image_src_path = determine_image_src_path(src, imgdata)
        image_dest_path = images_dir + "#{image_number}.#{ext}"

        # puts "image_dest_path: #{image_dest_path.to_s}"
        # puts "image_src_path: #{image_src_path.to_s}"

        FileUtils.cp(image_src_path, image_dest_path)
        image_number_increment

        image_dest_path.relative_path_from(dest_dir)
      end

      def determine_image_src_path(src, imgdata)
        return copy_temp_file(imgdata) if imgdata

        ext = File.extname(src).strip.downcase[1..-1]
        [ext, Pathname.new(ReverseAdoc.config.sourcedir) + src]
      end

      def copy_temp_file(imgdata)
        Tempfile.open(['radoc', '.jpg']) do |f|
          f.binmode
          f.write(Base64.strict_decode64(imgdata))
          f.rewind
          ext = Marcel::MimeType.for(f).sub(%r{^[^/]+/}, "")
          [ext, f.path]
        end
      end

      def to_coradoc(node, state = {})
        alt   = node['alt']
        src   = node['src']
        id = node['id']
        width = node['width']
        height = node['height']
        
        title = extract_title(node)

        if ReverseAdoc.config.external_images
          # puts "external image conversion #{id}, #{src}"
          src = datauri2file(src)
        end

        Coradoc::Document::Inline::Image.new(id: id,
          title: title, src: src, alt: alt, width: width, height: height)
      end
      def convert(node, state = {})
        Coradoc::Generator.gen_adoc(to_coradoc(node, state))
      end
    end

    register :img, Img.new
  end
end
