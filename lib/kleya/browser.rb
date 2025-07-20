module Kleya
  class Browser
    # @param options [Hash] browser options
    # @option options [Symbol] :viewport (:desktop) the viewport to use
    # @option options [Integer] :width (1920) the width of the viewport
    # @option options [Integer] :height (1080) the height of the viewport
    # @option options [Boolean] :headless (true) whether to run the browser in headless mode
    # @option options [Integer] :timeout (60) the timeout for the browser to navigate to the URL
    def initialize(**options)
      if options[:width] || options[:height]
        @viewport = Viewport.new(
          width: options[:width] || Preset::DESKTOP.width,
          height: options[:height] || Preset::DESKTOP.height
        )
      elsif options[:preset]
        if Preset.const_defined?(options[:preset].to_s.upcase)
          @viewport = Preset.const_get(options[:preset].to_s.upcase)
        else
          raise ArgumentError, "Preset #{options[:preset]} not found"
        end
      else
        @viewport = Preset::DESKTOP
      end

      @options = options
    end

    # @param url [String] the URL to screenshot
    # @param options [Hash] screenshot options
    # @option options [Symbol] :format (:jpeg) image format (:jpeg, :png)
    # @option options [Integer] :quality (90) JPEG quality (1-100)
    # @option options [Symbol] :encoding (:base64) output encoding
    # @return [Artifact] the screenshot artifact
    # @example Taking a X-optimized screenshot
    #   browser = Kleya::Browser.new(
    #     width: Kleya::Preset::X.width,
    #     height: Kleya::Preset::X.height
    #   )
    #   screenshot = browser.capture('https://example.com')
    def capture(url, options = {})
      browser.goto(url)

      format = options[:format] || :jpeg
      quality = options[:quality] || 90
      encoding = options[:encoding] || :base64

      data = browser.screenshot(
        format: format,
        quality: quality,
        encoding: encoding
      )

      Artifact.new(data:, url:, viewport: @viewport, format:, quality:, encoding:)
    rescue Ferrum::TimeoutError
      raise TimeoutError, 'Browser timed out'
    end

    # @return [void] quits the browser
    def quit
      @browser&.quit
      @browser = nil
    end

    private
      def browser
        @browser ||= Ferrum::Browser.new(
          headless: @options.fetch(:headless, true),
          browser_options: { 'no-sandbox': nil }.merge(**@options[:browser_options]),
          window_size: @viewport.to_a,
          timeout: @options[:timeout] || 60,
          process_timeout: @options[:process_timeout] || 60,
          **ferrum_options
        )
      end

      def ferrum_options
        @options.reject { |key, _| %i[width height headless timeout process_timeout].include?(key) }
      end
  end
end
