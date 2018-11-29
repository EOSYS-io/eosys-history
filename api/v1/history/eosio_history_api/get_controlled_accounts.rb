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
            coll = Api::Helper::MongoHelpers.get_collection('account_controls')
            JSON.parse(
              coll.find({ controlling_account: params[:controlling_account] })
              .projection(_id: 0, createdAt: 0)
              .to_a
              .to_json
            )
          end
        end
      end
    end
  end
end
