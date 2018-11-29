module Api
  module V1
    class Endpoint < Grape::API
      logger.formatter = GrapeLogging::Formatters::Rails.new
      use GrapeLogging::Middleware::RequestLogger, { logger: logger }

      mount History::Endpoint => '/v1/history'
    end
  end
end
