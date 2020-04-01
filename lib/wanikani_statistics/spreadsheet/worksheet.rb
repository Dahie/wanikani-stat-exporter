# frozen_string_literal: true

require 'erb'
require 'google_drive'

module WanikaniStatistics
  module Spreadsheet
    class Worksheet
      attr_reader :worksheet

      def initialize(worksheet)
        @worksheet = worksheet
      end

      def add_row(item)
        row_index = rows_count + 1

        set_row(row_index, item)
      end

      def set_row(row_index, item)
        item.column_mapping.each_with_index do |datafield, index|
          col_index = index + 1
          fill_value(row_index, col_index, item.send(datafield))
        end
      end

      def save
        worksheet.save
      end

      def fill_value(row_index, col_index, value)
        worksheet[row_index, col_index] = value
      end

      def rows_count
        worksheet.rows.count
      end
    end
  end
end
