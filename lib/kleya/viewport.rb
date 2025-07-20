module Kleya
  # Viewport dimensions
  # @example Creating a viewport
  #   Kleya::Viewport.new(width: 1200, height: 675) # => #<Viewport @width=1200 @height=675>
  class Viewport
    # @param width [Integer] the width of the viewport
    # @param height [Integer] the height of the viewport
    def initialize(width:, height:)
      @width = width
      @height = height
    end

    # @return [Hash] the viewport dimensions
    def to_h
      { width: @width, height: @height }
    end

    # @return [Array] the viewport dimensions
    def to_a
      [@width, @height]
    end

    # @param other [Viewport] the other viewport
    # @return [Boolean] whether the viewports are equal
    def ==(other)
      other.is_a?(Viewport) && @width == other.width && @height == other.height
    end

    # @return [String] the inspection of the viewport
    def inspect
      "#<#{self.class.name} @width=#{@width} @height=#{@height}>"
    end
  end
end
