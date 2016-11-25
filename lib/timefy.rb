# Copyright (c) 2016 Geza Benko - <geza.benko+github@gmail.xom>.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA
#
require 'spreadsheet'

class TimefyErrorValue < Exception
end

module Timefy

  ISSUE = 0
  DATE = 1
  HOUR = 2
  COMMENT = 3

  def self.parse_number(cell)
    return nil if cell.nil?
    Float(cell) rescue raise TimefyErrorValue, cell
  end

  def self.parse_date(cell)
    return nil if cell.nil?
    return DateTime.strptime(cell.strip, "%d/%m/%Y") rescue raise TimefyErrorDate, cell if cell.class == String
    cell
  end

  def self.parse_hours(cell)
    return nil if cell.nil?
    Float(cell.gsub(',','.')) rescue raise TimefyErrorHour, cell
  end

  def self.parse_text(cell)
    return nil if cell.nil?
    cell.strip
  end

  def self.parse_file(file, project, user)
    book = Spreadsheet.open(file.path)
    sheet = book.worksheet(0)
    count = 0

    TimeEntry.where(:project_id => project).transaction do
      sheet.each do |row|
        # the next items MUST be presents
        issue_id = parse_number(row[ISSUE])
        next if issue_id.nil?
        spent_on = parse_date(row[DATE])
        next if spent_on.nil?
        hours = parse_hours(row[HOUR])
        next if hours.nil?

        time_entry = TimeEntry.new
        time_entry.issue_id = issue_id
        time_entry.spent_on = spent_on
        time_entry.hours = hours
        time_entry.parse_text(row[COMMENT])
        time_entry.save!

        count += 1
      end
    end

    count
  end

end
