require "test_helper"

class WanikaniStatistics::KanjiTest < Minitest::Test

  def setup
    readings = [
          {
            "type" => "onyomi",
            "primary" => true,
            "accepted_answer" => true,
            "reading" => "いち"
          },
          {
            "type" => "onyomi",
            "primary" => true,
            "accepted_answer" => true,
            "reading" => "いちの"
          },
          {
            "type" => "kunyomi",
            "primary" => false,
            "accepted_answer" => false,
            "reading"=> "ひと"
          },
          {
            "type" => "nanori",
            "primary" => false,
            "accepted_answer" => false,
            "reading" => "かず"
          }
        ]
    @kanji = ::WanikaniStatistics::Kanji.new('一', 'one', readings)
  end

  def test_that_it_has_correct_onyomi
    assert_equal "いち, いちの", @kanji.onyomi
  end

  def test_that_it_has_correct_kunyomi
    assert_equal "ひと", @kanji.kunyomi
  end


end
