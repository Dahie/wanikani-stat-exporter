# frozen_string_literal: true

module Wanikani
  module Stat
    class Vocabulary
      attr_accessor :type, :character, :kana, :meaning

      COLUMN_MAPPING = %w[type character kana meaning].freeze

      def initialize(type, character, kana, meaning)
        @type = ""
        @character = character
        @kana = kana
        @meaning = meaning
      end

      def column_mapping
        COLUMN_MAPPING
      end
    end
  end
end
