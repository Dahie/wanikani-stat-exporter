module WanikaniStatistics
  class KanjiPersistor
    attr_reader :worksheet

    def initialize(worksheet)
      @worksheet = worksheet
    end

    def perform
      kanjis.each_with_index do |subject, index|
        kanji = Kanji.new(subject.dig('data', 'characters'),
                          subject.dig('data', 'meanings').first['meaning'],
                          subject.dig('data', 'readings'))
        worksheet.set_row(index + 2, kanji)
      end
      worksheet.save
    end

    def kanjis
      subjects.select{ |subject| subject['object'] == 'kanji' }
    end

    def subject_ids
      @subject_ids ||= assignments.map do |assignment|
        assignment.dig('data', 'subject_id')
      end.join(',')
    end

    def subjects
      @subjects = Wanikani::Subject.find_by(ids: subject_ids).data
    end

    def assignments
      @assignments ||= Wanikani::Assignment.find_by(started: true).data
    end
  end
end
