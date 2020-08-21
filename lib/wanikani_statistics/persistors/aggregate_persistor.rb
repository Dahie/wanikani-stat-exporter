module WanikaniStatistics
  class AggregatePersistor
    attr_reader :worksheet

    def initialize(worksheet)
      @worksheet = worksheet
    end

    def perform
      aggregate.level = current_level
      aggregate.apprentice_radicals = distribution.dig('Apprentice', 'radical')
      aggregate.apprentice_kanji = distribution.dig('Apprentice', 'kanji')
      aggregate.apprentice_vocabulary = distribution.dig('Apprentice', 'vocabulary')
      aggregate.guru_radicals = distribution.dig('Guru', 'radical')
      aggregate.guru_kanji = distribution.dig('Guru', 'kanji')
      aggregate.guru_vocabulary = distribution.dig('Guru', 'vocabulary')
      aggregate.master_radicals = distribution.dig('Master', 'radical')
      aggregate.master_kanji = distribution.dig('Master', 'kanji')
      aggregate.master_vocabulary = distribution.dig('Master', 'vocabulary')
      aggregate.enlighten_radicals = distribution.dig('Enlightened', 'radical')
      aggregate.enlighten_kanji = distribution.dig('Enlightened', 'kanji')
      aggregate.enlighten_vocabulary = distribution.dig('Enlightened', 'vocabulary')
      aggregate.burned_radicals = distribution.dig('Burned', 'radical')
      aggregate.burned_kanji = distribution.dig('Burned', 'kanji')
      aggregate.burned_vocabulary = distribution.dig('Burned', 'vocabulary')

      worksheet.add_row(aggregate)
      worksheet.save
    end

    def aggregate
      @aggregate ||= Aggregate.new
    end

    def user
      @user ||= Wanikani::User.fetch.data
    end

    def current_level
      user['level']
    end

    def assignments
      @assignments ||= Wanikani::Assignment.find_by(started: true).data
    end

    def map_stage_to_progression_names(stage)
      {
        0 => 'Unlocked',
        1 => 'Apprentice',
        2 => 'Apprentice',
        3 => 'Master',
        4 => 'Master',
        5 => 'Guru',
        6 => 'Guru',
        7 => 'Enlightened',
        8 => 'Enlightened',
        9 => 'Burned'
      }.fetch(stage)
    end

    def distribution
      return @distribution unless @distribution.nil?

      @distribution = Hash.new { |h,k| h[k] = {} }
      %w[Apprentice Master Guru Enlightened Burned].each do |stage|
        %w[radical kanji vocabulary].each do |type|
          @distribution[stage][type] = 0
        end
      end

      assignments.each do |assignment|
        stage = map_stage_to_progression_names(assignment.dig('data', 'srs_stage'))
        type = assignment.dig('data', 'subject_type')
        @distribution[stage][type] += 1
      end

      @distribution
    end
  end
end
