module Api
  module V1
    module History
      class GetActions < Grape::API
        format :json
        namespace 'get_actions' do
          post do
            coll = App::MongoPool.get_collection('action_traces')
            JSON.parse(
              coll.find().limit(10).to_a.to_json
            )
          end
        end
      end
    end
  end
end
