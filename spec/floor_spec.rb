require 'spec_helper'

describe Floor do
  subject { Floor.new(2) }

  it 'returns based url of the API end point, #uri' do
    expect(subject.uri).to eq "http://localhost:3000/v1/buildings/1/floors"
  end

  it 'serializes the object attribute as a json, #as_json' do
    json = { floor: { number: subject.number } }
    expect(subject.as_json).to eq json
  end

  it 'sends post request to the server with required params' do
    headers = {'Content-Type' => 'application/json'}
    json    = { floor: { number: subject.number }  }

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
