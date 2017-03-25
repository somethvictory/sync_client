require_relative "../src/apartment"
require_relative "../src/parser"
require_relative "../src/resident"
require_relative "../src/sync_service"
require_relative "../src/synchronizer"

RSpec.configure do |config|
    config.mock_framework = :rspec
end
