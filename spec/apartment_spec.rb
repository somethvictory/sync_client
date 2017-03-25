require 'spec_helper'

describe Apartment do
  before  { @floor = Floor.new(1) }

  subject { Apartment.new('123', @floor) }

  it 'returns based url of the API end point, #uri' do
    expect(subject.uri).to eq "http://localhost:3000/v1/floors/#{@floor.id}/apartments"
  end

  it 'serializes the object attribute as a json, #as_json' do
    json = { apartment: { external_id: subject.external_id } }
    expect(subject.as_json).to eq json
  end

  it 'sends post request to the server with required params' do
    headers = {'Content-Type' => 'application/json'}
    json    = { apartment: { external_id: subject.external_id }  }

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
