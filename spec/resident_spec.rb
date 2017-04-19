require 'spec_helper'

describe Floor do
  before do
    @floor = Floor.new(1)
    @apartment = Apartment.new('123', @floor)
  end

  subject { Resident.new(apartment: @apartment, external_id: '456', first_name: 'XYZ', last_name: 'ABC', email: 'xyz@abc.com', phone_number: '409-112-234') }

  it 'returns based url of the API end point, #url' do
    expect(subject.url).to eq "http://localhost:3000/v1/people"
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
    stub(:request)

    allow(res).to       receive(:request) {request}
    allow(request).to   receive(:code).and_return('201')
    allow(request).to   receive(:body).and_return({'data' => {'id' => 2}}.to_json)

    allow(Net::HTTP).to receive(:new).and_return(res)

    expect {
      subject.sync
    }.to change {
      subject.id
    }.from(nil).to(2)
  end
end
