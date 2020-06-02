require "test_helper"

class TranslationIO::APITest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TranslationIO::API::VERSION
  end
end
