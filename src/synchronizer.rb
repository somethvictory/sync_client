require 'uri'
require 'net/http'
require 'json'

class Synchronizer
  attr_accessor :id

  def sync
    uri     = URI(url)

    http    = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})

    request.body = self.as_json.to_json

    response = http.request(request)

    if response.code == '201'
      self.id = JSON.parse(response.body)['data']['id']
    else
      #failed request handler
    end
  end
end
