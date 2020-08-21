# frozen_string_literal: true

module WanikaniStatistics
  class Aggregate
    attr_accessor :created_at, :level,
                  :apprentice_radicals, :apprentice_kanji, :apprentice_vocabulary,
                  :guru_radicals, :guru_kanji, :guru_vocabulary,
                  :master_radicals, :master_kanji, :master_vocabulary,
                  :enlighten_radicals, :enlighten_kanji, :enlighten_vocabulary,
                  :burned_radicals, :burned_kanji, :burned_vocabulary,
                  :sum_radicals, :sum_kanji, :sum_vocabulary,
                  :sum_apprentice, :sum_enlighten, :sum_guru, :sum_master, :sum_burned

    COLUMN_MAPPING = %w[formatted_created_at level apprentice_radicals apprentice_kanji apprentice_vocabulary
                  guru_radicals guru_kanji guru_vocabulary
                  master_radicals master_kanji master_vocabulary
                  enlighten_radicals enlighten_kanji enlighten_vocabulary
                  burned_radicals burned_kanji burned_vocabulary
                  sum_radicals sum_kanji sum_vocabulary
                  sum_apprentice sum_enlighten sum_guru sum_master sum_burned
                ].freeze

    def initialize
      @created_at = Time.now
    end

    def formatted_created_at
      return nil unless created_at

      created_at.strftime("%d.%m.%Y %k:%M")
    end

    def column_mapping
      COLUMN_MAPPING
    end
  end
end
