require_relative 'test_helper'

class ViewportTest < Minitest::Test
  def setup
    @viewport = Kleya::Viewport.new(width: 100, height: 200)
  end

  def test_viewport_to_a
    assert_equal([100, 200], @viewport.to_a)
  end

  def test_viewport_to_h
    assert_equal({ width: 100, height: 200 }, @viewport.to_h)
  end

  def test_equality
    assert_equal(@viewport, Kleya::Viewport.new(width: 100, height: 200))
    refute_equal(@viewport, Kleya::Viewport.new(width: 200, height: 100))
  end
end
