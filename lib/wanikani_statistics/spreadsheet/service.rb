# frozen_string_literal: true

require 'erb'
require 'google_drive'

module WanikaniStatistics
  module Spreadsheet
    class Service
      attr_reader :spreadsheet_id

      def initialize(spreadsheet_id)
        @spreadsheet_id = spreadsheet_id
      end

      def worksheet_by_title(worksheet_title)
        spreadsheet.worksheet_by_title(worksheet_title)
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
