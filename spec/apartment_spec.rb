require 'spec_helper'

describe Apartment do
  before  { @floor = Floor.new(1) }

  subject { Apartment.new('123', @floor) }

  it 'returns based url of the API end point, #url' do
    expect(subject.url).to eq "http://localhost:3000/v1/floors/#{@floor.id}/apartments"
  end

  it 'serializes the object attribute as a json, #as_json' do
    json = { apartment: { external_id: subject.external_id } }
    expect(subject.as_json).to eq json
  end

  it 'sends post request to the server with required params' do
    headers = {'Content-Type' => 'application/json'}
    json    = { apartment: { external_id: subject.external_id }  }

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
