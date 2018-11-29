module Api
  module V1
    module History
      class GetKeyAccounts < Grape::API
        format :json
        namespace 'get_key_accounts' do
          params do
            requires :public_key, 
              type: String, 
              regexp: /\AEOS[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{50}\z/
          end

          post do
            filter = { public_key: params[:public_key] }
            options = { projection: { _id: 0, createdAt: 0 } }

            status = 200
            Api::Helper::MongoHelpers.find('pub_keys', filter, options)
          end
        end
      end
    end
  end
end
