module WanikaniStatistics
  class Export
    def initialize
      Wanikani.configure do |config|
        config.api_key = "71b78e92-2222-45b9-b196d0050c13d247"
        config.api_version = "v2"
      end

      response = Wanikani::Subject.find_by
      @subjects = response.data
    end

    def perform
      AggregatePersistor.new(aggregate_worksheet).perform
      VocabularyPersistor.new(vocabulary_worksheet).perform
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
  end
end
