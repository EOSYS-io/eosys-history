module History
  class Api < Grape::API
    format :json

    get do
      { message: "Hello World!" }
    end
  end
end