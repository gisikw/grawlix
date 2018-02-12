require "test_helper"

class TranslatorTest < Minitest::Test
  def test_translates_based_on_width
    translator = Grawlix::Translator.new(glyphs: "&!")
    assert_equal("!&!&!", translator.translate(".W.W."))
  end

  def test_ignores_whitelisted_chars
    translator = Grawlix::Translator.new(ignore: /^\s+$/)
    assert_equal("!! !!", translator.translate(".. .."))
  end
end
