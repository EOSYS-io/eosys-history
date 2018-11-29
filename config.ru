require File.expand_path('../config/environment', __FILE__)

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :post
  end
end

run Api::V1::Endpoint
