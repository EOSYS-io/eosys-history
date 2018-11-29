module Api
  module V1
    module History
      class GetTransaction < Grape::API
        format :json
        namespace 'get_transaction' do
          params do
            requires :id, type: String
          end

          post do
            query = { id: params[:id] }
            options = { projection: { _id: 0, createdAt: 0 } }

            status = 200
            Api::Helper::MongoHelpers.find_one('transaction_traces', query, options)
          end
        end
      end
    end
  end
end
