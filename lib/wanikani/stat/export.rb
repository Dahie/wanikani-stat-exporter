require 'wanikani'

module Wanikani
  module Stat
    class Export
      def initialize
      end

      def perform
        persist_record
      end

      def persist_record
        record.level = current_level
        record.apprentice_radicals = distribution.dig('apprentice', 'radicals')
        record.apprentice_kanji = distribution.dig('apprentice', 'kanji')
        record.apprentice_vocabulary = distribution.dig('apprentice', 'vocabulary')
        record.guru_radicals = distribution.dig('guru', 'radicals')
        record.guru_kanji = distribution.dig('guru', 'kanji')
        record.guru_vocabulary = distribution.dig('guru', 'vocabulary')
        record.master_radicals = distribution.dig('master', 'radicals')
        record.master_kanji = distribution.dig('master', 'kanji')
        record.master_vocabulary = distribution.dig('master', 'vocabulary')
        record.enlighten_radicals = distribution.dig('enlighten', 'radicals')
        record.enlighten_kanji = distribution.dig('enlighten', 'kanji')
        record.enlighten_vocabulary = distribution.dig('enlighten', 'vocabulary')
        record.burned_radicals = distribution.dig('burned', 'radicals')
        record.burned_kanji = distribution.dig('burned', 'kanji')
        record.burned_vocabulary = distribution.dig('burned', 'vocabulary')

        spreadsheet_service.add_row(record)
      end

      def spreadsheet_service
        @spreadsheet_service ||= SpreadsheetService.new(ENV['SPREADSHEET_ID'])
      end

      def record
        @record ||= Record.new
      end

      def client
        @client ||= ::Wanikani::Client.new(api_key: ENV['WANIKANI_API_KEY'])
      end

      def current_level
        client.user_information['level']
      end

      def user_information
        @user_information || client.user_information
      end

      def srs_distribution
        @srs_distribution ||= client.srs_distribution
      end

      def distribution
        srs_distribution
      end
    end
  end
end
