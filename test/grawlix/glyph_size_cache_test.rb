require "test_helper"

class GlyphSizeCacheTest < Minitest::Test
  def test_it_returns_widths_per_font
    refute_equal(
      Grawlix::GlyphSizeCache.new(File.join(File.dirname(__FILE__), '..', '..', 'OpenSans-Regular.ttf')).width_for("A"),
      Grawlix::GlyphSizeCache.new(File.join(File.dirname(__FILE__), '..', 'OpenSans-ExtraBold.ttf')).width_for("A"),
    )
  end
end
