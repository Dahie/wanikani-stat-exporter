# frozen_string_literal: true

module Wanikani
  module Stat
    class Vocabulary
      attr_accessor :character, :kana, :meaning

      COLUMN_MAPPING = %w[character kana meaning].freeze

      def column_mapping
        COLUMN_MAPPING
      end
    end
  end
end
