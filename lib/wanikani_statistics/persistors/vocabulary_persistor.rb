module WanikaniStatistics
  class VocabularyPersistor
    attr_reader :worksheet

    def initialize(worksheet)
      @worksheet = worksheet
    end

    def perform
      vocabulary.each_with_index do |subject, index|
        vocabulary = Vocabulary.new(subject.dig('object'),
                                    subject.dig('data', 'characters'),
                                    subject.dig('data', 'readings').first['reading'],
                                    subject.dig('data', 'meanings').first['meaning'])
        worksheet.set_row(index + 2, vocabulary)
      end
      worksheet.save
    end

    def vocabulary
      subjects.select{ |subject| subject['object'] == 'vocabulary' }
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
