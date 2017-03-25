require 'roo'
require 'pry'

require_relative 'floor'
require_relative 'apartment'
require_relative 'resident'

class Parser
  def initialize(csv)
    @csv = Roo::CSV.new(csv).drop(1)
  end

  def floors
    #row[0][0] First char of first column of the row
    @floors ||= @csv.map { |row| Floor.new(row[0][0]) }
  end

  def apartments
    @apartments ||= @csv.map do |row|
      floor = floors.find { |floor| floor.number == row[0][0] }
      Apartment.new(row[0], floor)
    end
  end

  def residents
    @residents ||= @csv.map do |row|
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
