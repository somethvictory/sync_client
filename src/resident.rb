require_relative 'synchronizer'

class Resident < Synchronizer
  attr_reader :id, :apartment, :external_id, :first_name, :last_name, :email, :phone_number

  def initialize(options)
    external_id  = options[:external_id].to_s
    first_name   = options[:first_name].to_s
    last_name    = options[:last_name].to_s
    email        = options[:email].to_s
    phone_number = options[:phone_number].to_s

    @apartment    = options[:apartment]
    @external_id  = external_id.empty?  ? 'Unknown' : external_id
    @first_name   = first_name.empty?   ? 'Unknown' : first_name
    @last_name    = last_name.empty?    ? 'Unknown' : last_name
    @email        = email.empty?        ? 'Unknown' : email
    @phone_number = phone_number.empty? ? 'Unknown' : phone_number
  end

  def url
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
