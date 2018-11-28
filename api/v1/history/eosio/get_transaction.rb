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
            coll = App::MongoPool.get_collection('transaction_traces')

            coll.find({ id: params[:id] })
            .projection(_id: 0, createdAt: 0)
            .first
          end
        end
      end
    end
  end
end
