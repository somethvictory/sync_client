require_relative 'synchronizer'

class Floor < Synchronizer
  attr_reader :id, :number

  def initialize(number)
    @number = number
  end

  def url
    'http://localhost:3000/v1/buildings/1/floors'
  end

  def as_json
    {
      floor: { number: number }
    }
  end
end
