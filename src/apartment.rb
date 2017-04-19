require_relative 'synchronizer'
require_relative 'floor'

class Apartment < Synchronizer
  attr_reader :external_id, :floor

  def initialize(external_id, floor)
    @external_id = external_id.strip
    @floor       = floor
  end

  def url
    "http://localhost:3000/v1/floors/#{floor.id}/apartments"
  end

  def as_json
    {
      apartment: { external_id: external_id }
    }
  end
end
