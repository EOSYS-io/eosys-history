module Api
  module V1 
    module History
      class Endpoint < Grape::API
        mount Api::V1::History::GetActions
      end
    end
  end
end
