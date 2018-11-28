module Api
  class Endpoint < Grape::API
    mount Api::V1::History::Endpoint => '/v1/history'
  end
end
