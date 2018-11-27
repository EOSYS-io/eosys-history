module Api
  module V1
    module History
      class GetActions < Grape::API
        format :json
        namespace 'get_actions' do
          post do
            { message: "Hello Get Actions!" }
          end
        end
      end
    end
  end
end
