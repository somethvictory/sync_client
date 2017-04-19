require 'csv'

require_relative 'floor'
require_relative 'apartment'
require_relative 'resident'

class Parser

  attr_reader :row

  def initialize(csv)
    @row = []
    CSV.foreach(csv) do |row|
      @row.push row
    end
  end

  def floors
    #row[0][0] First char of first column of the row
    @floors ||= @row.map { |row| Floor.new(row[0][0]) }
  end

  def apartments
    @apartments ||= @row.map do |row|
      floor = floors.find { |floor| floor.number == row[0][0] }
      Apartment.new(row[0], floor)
    end
  end

  def residents
    @residents ||= @row.map do |row|
      apartment = apartments.find { |apartment| apartment.external_id.strip == row[0].strip }
      Resident.new(
        apartment:    apartment,
        external_id:  row[1],
        first_name:   row[2],
        last_name:    row[3],
        email:        row[4],
        phone_number: row[5]
      )
    end
  end
end
