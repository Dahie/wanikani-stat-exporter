# frozen_string_literal: true

module WanikaniStatistics
  class Kanji
    attr_accessor :character, :onyomi, :kunyomi, :nanori, :meaning

    COLUMN_MAPPING = %w[character meaning onyomi kunyomi nanori].freeze

    def initialize(character, meaning, readings)
      @character = character
      @meaning = meaning
      @onyomi = readings
                  .select { |reading| reading['type'] == 'onyomi' }
                  .map { |reading| reading['reading'] }.join(', ')
      @kunyomi = readings.select { |reading| reading['type'] == 'kunyomi' }.map { |reading| reading['reading'] }.join(', ')
    end

    def column_mapping
      COLUMN_MAPPING
    end
  end
end
