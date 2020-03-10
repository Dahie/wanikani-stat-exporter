# frozen_string_literal: true

module Wanikani
  module Stat
    class Record
      attr_accessor :created_at, :level,
                    :apprentice_radicals, :apprentice_kanji, :apprentice_vocabulary,
                    :guru_radicals, :guru_kanji, :guru_vocabulary,
                    :master_radicals, :master_kanji, :master_vocabulary,
                    :enlighten_radicals, :enlighten_kanji, :enlighten_vocabulary,
                    :burned_radicals, :burned_kanji, :burned_vocabulary
    end
  end
end
