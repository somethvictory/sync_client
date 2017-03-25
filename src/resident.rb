require_relative 'synchronizer'

class Resident < Synchronizer
  attr_reader :id, :apartment, :external_id, :first_name, :last_name, :email, :phone_number

  def initialize(options)
    @apartment    = options[:apartment]
    @external_id  = options[:external_id].to_s.strip
    @first_name   = options[:first_name].to_s.strip
    @last_name    = options[:last_name].to_s.strip
    @email        = options[:email].to_s.strip
    @phone_number = options[:phone_number].to_s.strip
  end

  def uri
    'http://localhost:3000/v1/people'
  end

  def as_json
    {
      resident: {
        apartment_id: apartment.id,
        external_id:  external_id,
        first_name:   first_name,
        last_name:    last_name,
        email:        email,
        phone_number: phone_number
      }
    }
  end
end
