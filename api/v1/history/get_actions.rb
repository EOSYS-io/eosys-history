module Api
  module V1
    module History
      class GetActions < Grape::API
        format :json
        namespace 'get_actions' do
          post do
            coll = App::MongoPool.get_collection('action_traces')
            coll.find().limit(1).first
          end
        end
      end
    end
  end
end
