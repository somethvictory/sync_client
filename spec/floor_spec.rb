require 'spec_helper'

describe Floor do
  subject { Floor.new(2) }

  it 'returns based url of the API end point, #url' do
    expect(subject.url).to eq "http://localhost:3000/v1/buildings/1/floors"
  end

  it 'serializes the object attribute as a json, #as_json' do
    json = { floor: { number: subject.number } }
    expect(subject.as_json).to eq json
  end

  it 'sends post request to the server with required params' do
    headers = {'Content-Type' => 'application/json'}
    json    = { floor: { number: subject.number }  }

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
