# frozen_string_literal: true

module Wanikani
  module Stat
    class Aggregate
      attr_accessor :created_at, :level,
                    :apprentice_radicals, :apprentice_kanji, :apprentice_vocabulary,
                    :guru_radicals, :guru_kanji, :guru_vocabulary,
                    :master_radicals, :master_kanji, :master_vocabulary,
                    :enlighten_radicals, :enlighten_kanji, :enlighten_vocabulary,
                    :burned_radicals, :burned_kanji, :burned_vocabulary

      COLUMN_MAPPING = %w[formatted_created_at level apprentice_radicals apprentice_kanji apprentice_vocabulary
                    guru_radicals guru_kanji guru_vocabulary
                    master_radicals master_kanji master_vocabulary
                    enlighten_radicals enlighten_kanji enlighten_vocabulary
                    burned_radicals burned_kanji burned_vocabulary].freeze

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
end
