require 'spec_helper'

describe Floor do
  before do
    @floor = Floor.new(1)
    @apartment = Apartment.new('123', @floor)
  end

  subject { Resident.new(apartment: @apartment, external_id: '456', first_name: 'XYZ', last_name: 'ABC', email: 'xyz@abc.com', phone_number: '409-112-234') }

  it 'returns based url of the API end point, #uri' do
    expect(subject.uri).to eq "http://localhost:3000/v1/people"
  end

  it 'serializes the object attribute as a json, #as_json' do
    json = {
      resident: {
        apartment_id: subject.apartment.id,
        external_id:  subject.external_id,
        first_name:   subject.first_name,
        last_name:    subject.last_name,
        email:        subject.email,
        phone_number: subject.phone_number
      }
    }
    expect(subject.as_json).to eq json
  end

  it 'sends post request to the server with required params' do
    headers = {'Content-Type' => 'application/json'}
    json = {
      resident: {
        apartment_id: subject.apartment.id,
        external_id:  subject.external_id,
        first_name:   subject.first_name,
        last_name:    subject.last_name,
        email:        subject.email,
        phone_number: subject.phone_number
      }
    }

    stub(:res)

    allow(Typhoeus).to receive(:post).with(subject.uri, headers: headers, body: json.to_json).and_return(res)
    allow(res).to receive(:response_code).and_return(201)
    allow(res).to receive(:body).and_return({'data' => {'id' => 2}}.to_json)

    expect {
      subject.sync
    }.to change {
      subject.id
    }.from(nil).to(2)
  end
end
