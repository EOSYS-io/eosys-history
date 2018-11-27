module Api
  class Endpoint < Grape::API
    mount Api::V1::History::GetActions => '/v1/history'
  end
end
