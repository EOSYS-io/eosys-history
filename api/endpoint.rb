module Api
  module V1
    class Endpoint < Grape::API
      logger.formatter = GrapeLogging::Formatters::Rails.new
      use GrapeLogging::Middleware::RequestLogger, { logger: logger }

      get '/health_check' do
        status 200
      end

      mount History::Endpoint => '/v1/history'
    end
  end
end
