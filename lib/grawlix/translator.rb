module Grawlix
  class Translator
    DEFAULTS = {
      memoize: true,
      glyphs: "!$%*&@#£¥€Þ§¢~^?",
      ignore: /^\s+$/,
      noise: 0.1
    }

    def initialize(opts = {})
      @cache = GlyphSizeCache.new      
      @opts = DEFAULTS.merge(opts)
      @glyph_dict = @opts[:glyphs].split('').each_with_object({}) { |g, h| (h[@cache.width_for(g)] ||= []) << g }.to_a.sort_by { |p| p[0] }
      @widths, @glyphs = @glyph_dict.transpose
      @memo = {}
    end

    def translate(input)
      input.split('').map { |c| c =~ @opts[:ignore] ? c : glyph_for(c) }.join
    end

    private

    def glyph_for(char)
      if @opts[:memoize]
        @memo[char] ||= glyph_for_raw(char)
      else
        glyph_for_raw(char)
      end
    end

    def glyph_for_raw(char)
      noise = @opts[:noise].to_f
      target = @cache.width_for(char) + (noise * rand) - noise / 2
      nearest_glyph(target).sample
    end

    def nearest_glyph(target)
      max = @widths.each_with_index.to_a.bsearch { |w,i| target < w }
      max = max[1] if max
      return @glyphs[-1] if !max
      return @glyphs[0] if max == 0
      if (target - @widths[max]).abs < (target - @widths[max - 1]).abs
        @glyphs[max]
      else
        @glyphs[max - 1]
      end
    end

  end
end
