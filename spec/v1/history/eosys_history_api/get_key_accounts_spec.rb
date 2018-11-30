require 'spec_helper'

describe Api::V1::History::GetKeyAccounts do
  include Rack::Test::Methods

  def app
    Api::V1::History::GetKeyAccounts
  end

  context 'POST /v1/history/get_key_accounts' do
    it 'returns 400 when there is no public_key field' do
      request_body = { text: '...' }
      post '/v1/history/get_key_accounts', request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq({ error: "public_key is missing" }.to_json)
    end

    it 'returns 400 when invalid public_key is provided' do
      request_body = { public_key: 'INVALID' }
      post '/v1/history/get_key_accounts', request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq({ error: "public_key is invalid" }.to_json)
    end

    it 'returns 200 with accounts when there exists accounts' do
      accounts = [
        {
          account: "testacc",
          permission: "owner",
          public_key: "EOS3gDQcTqucwqkozkMG8Akq5tZkSMmj3TDKp7u2gK2vN6N3g7RiF"
        },
        {
          account: "testacc",
          permission: "active",
          public_key: "EOS3gDQcTqucwqkozkMG8Akq5tZkSMmj3TDKp7u2gK2vN6N3g7RiF"
        }
     ]
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return(accounts)

      request_body = { public_key: 'EOS3gDQcTqucwqkozkMG8Akq5tZkSMmj3TDKp7u2gK2vN6N3g7RiF' }
      post '/v1/history/get_key_accounts', request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(accounts.to_json)
    end

    it 'returns 200 with empty array' do
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return([])

      request_body = { public_key: 'EOS7gDQcTqucwqkozkMG8Akq5tZkSMmj3TDKp7u2gK2vN6N3g7RiF' }
      post '/v1/history/get_key_accounts', request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq([].to_json)
    end
  end
end
