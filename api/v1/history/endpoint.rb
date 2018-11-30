module Api
  module V1
    module History
      class Endpoint < Grape::API
        mount Api::V1::History::GetActions
        mount Api::V1::History::GetControlledAccounts
        mount Api::V1::History::GetKeyAccounts
        mount Api::V1::History::GetTransaction
      end
    end
  end
end
