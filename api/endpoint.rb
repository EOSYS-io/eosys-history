module Api
  module V1
    class Endpoint < Grape::API
      mount History::Endpoint => '/v1/history'
    end
  end
end
