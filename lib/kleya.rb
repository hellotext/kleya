require 'ferrum'

require_relative 'kleya/errors'
require_relative 'kleya/preset'
require_relative 'kleya/artifact'
require_relative 'kleya/browser'

module Kleya
  VERSION = '0.0.1'

  # Instanciates a browser instance, takes the screenshot and quits the browser to conserve memory.

  # @param url [String] the URL to screenshot
  # @param options [Hash] screenshot options
  # @option options [Symbol] :viewport (:desktop) the viewport to use
  # @option options [Symbol] :format (:jpeg) image format (:jpeg, :png)
  # @option options [Integer] :quality (90) JPEG quality (1-100)
  # @option options [Symbol] :encoding (:binary) output encoding
  # @return [String] binary image data
  # @example Taking a Twitter-optimized screenshot
  #   Kleya.capture('https://example.com', viewport: :twitter)
  def self.capture(url, **options)
    browser = Browser.new(**options)
    browser.capture(url, **options)
  ensure
    browser.quit
  end
end
