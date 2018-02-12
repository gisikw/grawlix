require 'ttfunk'

module Grawlix
  class GlyphSizeCache
    DEFAULT_FONT_PATH = File.join(File.dirname(__FILE__), '..', '..', 'OpenSans-Regular.ttf')

    def initialize(font_path = DEFAULT_FONT_PATH)
      @file = TTFunk::File.open(font_path)
      @cache = {}
    end

    def width_for(character)
      @cache[character] ||= @file.horizontal_metrics.for(@file.cmap.unicode.first[character.unpack("U*").first]).advance_width.to_f / em_size
    end

    def em_size
      @em ||= @file.header.units_per_em
    end
  end
end
