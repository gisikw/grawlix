require "test_helper"

class GrawlixTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Grawlix::VERSION
  end
end
