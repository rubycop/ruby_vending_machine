# frozen_string_literal: true

require 'terminal-table'
require 'rainbow'
require 'readline'
require_relative '../utils/format_string'

module Services
  # IOService processing input/output
  class IOService
    def self.print_table(rows:, headings: [])
      table_output = Terminal::Table.new(headings: headings, rows: rows)
      $stdout.puts(table_output.to_s.colorize(:yellow))
    end

    def self.print_message(message)
      $stdout.puts # add newline for better look
      $stdout.puts(message)
    end

    def self.print_error(message)
      warn(message.colorize(:red))
    end

    def self.readline(message)
      Readline.readline(message, false)
    end
  end
end
