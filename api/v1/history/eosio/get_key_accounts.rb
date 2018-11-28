module Api
  module V1
    module History
      class GetKeyAccounts < Grape::API
        format :json
        namespace 'get_key_accounts' do
          params do
            requires :public_key, 
              type: String, 
              regexp: /^EOS[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{50}$/
          end
          post do
            coll = App::MongoPool.get_collection('pub_keys')
            JSON.parse(
              coll.find({ public_key: params[:public_key] })
              .projection(_id: 0)
              .to_a
              .to_json
            )
          end
        end
      end
    end
  end
end
