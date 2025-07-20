require 'base64'

module Kleya
  class Artifact
    # @param data [String] the screenshot data (base64 or binary)
    # @param url [String] the URL that was captured
    # @param viewport [Viewport] the viewport used
    # @param format [Symbol] the image format (:jpeg, :png)
    # @param quality [Integer] the quality (1-100)
    # @param encoding [Symbol] the data encoding (:base64, :binary)
    def initialize(data:, url:, viewport:, format:, encoding:, quality: nil)
      @data = data
      @url = url
      @viewport = viewport
      @format = format
      @quality = quality
      @encoding = encoding
      @captured_at = Time.now
    end

    # @return [Integer] the size of the artifact
    def size
      binary.bytesize
    end

    # @param prefix [String] optional prefix for the filename
    # @return [String] a generated filename for the artifact
    def filename(prefix: 'screenshot')
      timestamp = @captured_at.strftime('%Y%m%d_%H%M%S')
      extension = @format == :jpeg ? 'jpg' : @format.to_s

      "#{prefix}_#{timestamp}.#{extension}"
    end

    # @param path [String] the path to save the artifact
    # @return [String] the full path where the file was saved
    def save(path = nil)
      if path.nil?
        path = filename
      elsif File.directory?(path)
        path = File.join(path, filename)
      end

      File.write(path, binary, mode: 'wb').then { path }
    end

    # @return [String] the base64-encoded data of the artifact
    def base64
      @encoding == :base64 ? @data : Base64.encode64(@data)
    end

    # @return [String] the binary data of the artifact
    def binary
      @encoding == :binary ? @data : Base64.decode64(@data)
    end

    # @return [String] the content type of the artifact
    def content_type
      case @format
      when :jpeg, :jpg then 'image/jpeg'
      when :png then 'image/png'
      else "image/#{@format}"
      end
    end

    # @return [Hash] the dimensions of the artifact
    def dimensions
      @viewport.to_h
    end

    # @return [String] the inspection of the artifact
    def inspect
      "#<#{self.class.name} @url=#{@url} @viewport=#{@viewport.inspect} @format=#{@format} @quality=#{@quality} @encoding=#{@encoding} @captured_at=#{@captured_at}>"
    end
  end
end
