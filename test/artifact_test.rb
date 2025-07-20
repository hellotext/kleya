require_relative 'test_helper'

class ArtifactTest < Minitest::Test
  def setup
    @artifact = Kleya::Artifact.new(
      data: Base64.encode64('test'),
      url: 'https://example.com',
      viewport: Kleya::Viewport.new(width: 100, height: 200),
      format: :jpeg,
      encoding: :base64
    )
  end

  def test_artifact_size
    assert_equal(4, @artifact.size)
  end

  def test_artifact_save
    assert_runs_without_errors do
      @artifact.save('test.jpg')
    end
  end

  def test_artifact_base64
    assert_equal(Base64.encode64('test'), @artifact.base64)
  end

  def test_artifact_binary
    assert_equal('test', @artifact.binary)
  end

  def test_artifact_content_type_jpeg
    assert_equal('image/jpeg', @artifact.content_type)
  end

  def test_artifact_content_type_png
    artifact = Kleya::Artifact.new(
      data: Base64.encode64('test'),
      url: 'https://example.com',
      viewport: Kleya::Viewport.new(width: 100, height: 200),
      format: :png,
      encoding: :base64
    )

    assert_equal('image/png', artifact.content_type)
  end

  def test_artifact_content_type_invalid
    artifact = Kleya::Artifact.new(
      data: Base64.encode64('test'),
      url: 'https://example.com',
      viewport: Kleya::Viewport.new(width: 100, height: 200),
      format: :invalid,
      encoding: :base64
    )

    assert_equal('image/invalid', artifact.content_type)
  end

  def test_artifact_dimensions
    assert_equal({ width: 100, height: 200 }, @artifact.dimensions)
  end
end
