require 'typhoeus'
require 'json'
require 'pry'

class Synchronizer
  attr_accessor :id

  def sync
    res = Typhoeus.post(uri,
                 headers: {'Content-Type' => 'application/json'},
                 body: self.as_json.to_json
                )
    if res.response_code == 201
      self.id = JSON.parse(res.body)['data']['id']
    else
      #failed request handler
    end
  end
end
