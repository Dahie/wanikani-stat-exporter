module WanikaniStatistics
  class Export
    def initialize
      Wanikani.configure do |config|
        config.api_key = ENV['WANIKANI_API_KEY']
      end

      response = Wanikani::Subject.find_by
      @subjects = response.data
    end

    def perform
      AggregatePersistor.new(aggregate_worksheet).perform
      KanjiPersistor.new(kanji_worksheet).perform
      VocabularyPersistor.new(vocabulary_worksheet).perform
    end

    def aggregate_worksheet
      @aggregate_worksheet ||=
        Spreadsheet::Worksheet.new(spreadsheet_service.worksheet_by_title('Raw'))
    end

    def kanji_worksheet
      @kanji_worksheet ||=
        Spreadsheet::Worksheet.new(spreadsheet_service.worksheet_by_title('Kanji'))
    end

    def vocabulary_worksheet
      @vocabulary_worksheet ||=
        Spreadsheet::Worksheet.new(spreadsheet_service.worksheet_by_title('Vocabulary'))
    end

    def spreadsheet_service
      @spreadsheet_service ||= Spreadsheet::Service.new(ENV['SPREADSHEET_ID'])
    end
  end
end
