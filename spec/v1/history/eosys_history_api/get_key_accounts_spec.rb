require 'spec_helper'

describe Api::V1::History::GetKeyAccounts do
  include Rack::Test::Methods

  def app
    Api::V1::History::GetKeyAccounts
  end

  context 'POST /v1/history/get_key_accounts' do
    it 'returns 400 when there is no public_key field' do
      statuses = { text: '...' }
      post '/v1/history/get_key_accounts', statuses.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq({ error: "public_key is missing" }.to_json)
    end
  end
end
