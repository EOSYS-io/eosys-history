module Api
  module V1
    module History
      class GetControlledAccounts < Grape::API
        format :json
        namespace 'get_controlled_accounts' do
          params do
            requires :controlling_account, type: String
          end

          post do
            filter = { controlling_account: params[:controlling_account] }
            options = { projection: { _id: 0, createdAt: 0 } }

            status = 200
            Api::Helper::MongoHelpers.find('account_controls', filter, options)
          end
        end
      end
    end
  end
end
