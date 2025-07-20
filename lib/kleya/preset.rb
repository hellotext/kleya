require_relative 'viewport'

module Kleya
  # Social media platform viewport dimensions
  # @example Using Twitter preset
  #   Kleya::Preset::TWITTER # => #<Viewport @width=1200 @height=675>
  module Preset
    TWITTER = Viewport.new(width: 1200, height: 675)
    FACEBOOK = Viewport.new(width: 1200, height: 630)
    LINKEDIN = Viewport.new(width: 1200, height: 627)
    INSTAGRAM = Viewport.new(width: 1080, height: 1080)

    DESKTOP = Viewport.new(width: 1920, height: 1080)
    LAPTOP = Viewport.new(width: 1366, height: 768)
    TABLET = Viewport.new(width: 768, height: 1024)
    MOBILE = Viewport.new(width: 375, height: 667)
  end
end
