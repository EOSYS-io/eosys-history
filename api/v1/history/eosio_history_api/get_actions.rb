module Api
  module V1
    module History
      class GetActions < Grape::API
        format :json
        namespace 'get_actions' do
          params do
            requires :account_name, 
              type: String, 
              regexp: /\A[a-z1-5.]{1,12}\z/
            optional :skip, type: Integer, default: 0
            optional :limit, type: Integer, default: 10, values: 1..100
            optional :sort, type: Integer, default: -1, values: [1, -1]
          end

          post do
            filter = {
              '$or' => [
                { 'act.account': params[:account_name] },
                { 'act.authorization.actor': params[:account_name] },
                { 'act.data.from': params[:account_name] },
                { 'act.data.name': params[:account_name] },
                { 'act.data.receiver': params[:account_name] },
                { 'act.data.to': params[:account_name] },
                { 'act.data.voter': params[:account_name] }
              ]
            }

            options = {
              sort: { _id: params[:sort] },
              skip: params[:skip],
              limit: params[:limit],
              projection: { _id: 0, createdAt: 0 }
            }

            status = 200
            { actions: Api::Helper::MongoHelpers.find('action_traces', filter, options) }
          end
        end
      end
    end
  end
end
