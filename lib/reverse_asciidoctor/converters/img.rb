require "fileutils"
require "pathname"

module ReverseAsciidoctor
  module Converters
    class Img < Base

      def image_number
        sprintf(
          ReverseAsciidoctor.config.image_counter_pattern,
          ReverseAsciidoctor.config.image_counter
        )
      end

      def image_number_increment
        ReverseAsciidoctor.config.image_counter += 1
      end

      def datauri2file(src)
        %r{^data:image/(?<imgtype>[^;]+);base64,(?<imgdata>.+)$} =~ src

        dest_dir = Pathname.new(ReverseAsciidoctor.config.destination).dirname
        images_dir = dest_dir + 'images'
        FileUtils.mkdir_p(images_dir)

        ext = ""

        if imgdata
          file = Tempfile.new(["radoc", ".jpg"]) do |f|
            f.binmode
            f.write(Base64.strict_decode64(imgdata))
            f.rewind
            ext = MimeMagic.by_magic(f)
          end

          image_src_path = file.path
          # puts "tempfile: #{file}"

        else
          ext = File.extname(src).strip.downcase[1..-1]
          image_src_path = Pathname.new(ReverseAsciidoctor.config.sourcedir) + src

        end

        image_dest_path = images_dir + "#{image_number}.#{ext}"

        # puts "image_dest_path: #{image_dest_path.to_s}"
        # puts "image_src_path: #{image_src_path.to_s}"

        FileUtils.cp(image_src_path, image_dest_path)
        image_number_increment

        image_dest_path.relative_path_from(dest_dir)
      end

      def convert(node, state = {})
        alt   = node['alt']
        src   = node['src']
        id = node['id']
        width = node['width']
        height = node['height']
        anchor = id ? "[[#{id}]]\n" : ""
        title = extract_title(node)

        if ReverseAsciidoctor.config.external_images
          # puts "external image conversion #{id}, #{src}"
          src = datauri2file(src)
        end

        title = ".#{title}\n" unless title.empty?
        attrs = alt
        attrs = "\"\"" if (width || height) && alt.nil?
        attrs += ",#{width}" if width
        attrs += ",#{height}" if width && height
        [anchor, title, "image::", src, "[", attrs, "]"].join("")
      end
    end

    register :img, Img.new
  end
end
