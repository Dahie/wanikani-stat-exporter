require 'wanikani'

module Wanikani
  module Stat
    class Export
      def initialize
      end

      def perform
        persist_aggregate
        persist_vocabulary
      end

      def persist_aggregate
        aggregate.level = current_level
        aggregate.apprentice_radicals = distribution.dig('apprentice', 'radicals')
        aggregate.apprentice_kanji = distribution.dig('apprentice', 'kanji')
        aggregate.apprentice_vocabulary = distribution.dig('apprentice', 'vocabulary')
        aggregate.guru_radicals = distribution.dig('guru', 'radicals')
        aggregate.guru_kanji = distribution.dig('guru', 'kanji')
        aggregate.guru_vocabulary = distribution.dig('guru', 'vocabulary')
        aggregate.master_radicals = distribution.dig('master', 'radicals')
        aggregate.master_kanji = distribution.dig('master', 'kanji')
        aggregate.master_vocabulary = distribution.dig('master', 'vocabulary')
        aggregate.enlighten_radicals = distribution.dig('enlighten', 'radicals')
        aggregate.enlighten_kanji = distribution.dig('enlighten', 'kanji')
        aggregate.enlighten_vocabulary = distribution.dig('enlighten', 'vocabulary')
        aggregate.burned_radicals = distribution.dig('burned', 'radicals')
        aggregate.burned_kanji = distribution.dig('burned', 'kanji')
        aggregate.burned_vocabulary = distribution.dig('burned', 'vocabulary')

        aggregate_worksheet.add_row(aggregate)
        aggregate_worksheet.save
      end

      def persist_vocabulary
        all_active_vocabulary.each_with_index do |item, index|
          vocabulary = Vocabulary.new(item.fetch('type', ''), item['character'], item['kana'], item['meaning'])
          vocabulary_worksheet.set_row(index + 2, vocabulary)
        end
        vocabulary_worksheet.save
      end

      def aggregate_worksheet
        @aggregate_worksheet ||=
          Spreadsheet::Worksheet.new(spreadsheet_service.worksheet_by_title('Raw'))
      end

      def vocabulary_worksheet
        @vocabulary_worksheet ||=
          Spreadsheet::Worksheet.new(spreadsheet_service.worksheet_by_title('Vocabulary'))
      end

      def spreadsheet_service
        @spreadsheet_service ||= Spreadsheet::Service.new(ENV['SPREADSHEET_ID'])
      end

      def aggregate
        @aggregate ||= Aggregate.new
      end

      def vocabulary
        @vocabulary ||= Vocabulary.new
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

      def distribution
        @distribution ||= client.srs_distribution
      end

      def radicals_list
        @radicals_list ||= client.radicals_list
      end

      def active_radicals_list
        radicals_list.reject{ |item| item['user_specific'].nil?  }
      end

      def kanji_list
        @kanji_list ||= client.kanji_list
      end

      def active_kanji_list
        kanji_list.reject{ |item| item['user_specific'].nil?  }
      end

      def vocabulary_list
        @vocabulary_list ||= client.vocabulary_list
      end

      def active_vocabulary_list
        vocabulary_list.reject{ |item| item['user_specific'].nil?  }
      end

      def all_active_vocabulary
        #active_radicals_list.merge(active_kanji_list).merge(active_vocabulary_list)
        active_radicals_list + active_kanji_list + active_vocabulary_list
      end
    end
  end
end
