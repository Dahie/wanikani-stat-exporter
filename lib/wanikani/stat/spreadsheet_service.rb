# frozen_string_literal: true

require 'erb'
require 'google_drive'

COLUMN_MAPPING = %w[level apprentice_radicals apprentice_kanji apprentice_vocabulary
                    guru_radicals guru_kanji guru_vocabulary
                    master_radicals master_kanji master_vocabulary
                    enlighten_radicals enlighten_kanji enlighten_vocabulary
                    burned_radicals burned_kanji burned_vocabulary].freeze

module Wanikani
  module Stat
    class SpreadsheetService
      attr_reader :spreadsheet_id

      def initialize(spreadsheet_id)
        @spreadsheet_id = spreadsheet_id
      end

      def add_row(record)
        row_index = rows_count + 1
        fill_value(row_index, 1, Time.now)

        COLUMN_MAPPING.each_with_index do |datafield, index|
          col_index = index + 2
          fill_value(row_index, col_index, record.send(datafield))
        end

        worksheet.save
      end

      def fill_value(row_index, col_index, value)
        worksheet[row_index, col_index] = value
      end

      def worksheet
        @worksheet ||= spreadsheet.worksheets[0]
      end

      def rows_count
        worksheet.rows.count
      end

      def spreadsheet
        @spreadsheet ||= session.spreadsheet_by_key(spreadsheet_id)
      end

      def config
        OpenStruct.new(save: true,
                       client_id: ENV['DRIVE_CLIENT_ID'],
                       client_secret: ENV['DRIVE_CLIENT_SECRET'],
                       scope: [
                         'https://www.googleapis.com/auth/drive',
                         'https://spreadsheets.google.com/feeds/'
                       ],
                       refresh_token: ENV['DRIVE_REFRESH_TOKEN'])
      end

      def session
        @session ||= GoogleDrive::Session.from_config(config)
      end
    end
  end
end
