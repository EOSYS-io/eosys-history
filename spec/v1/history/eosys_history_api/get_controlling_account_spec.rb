describe Api::V1::History::GetControlledAccounts do
  include Rack::Test::Methods

  def app
    Api::V1::History::GetControlledAccounts
  end

  context 'POST /v1/history/get_controlled_accounts' do
    it 'returns 400 when there is no controlling_account field' do
      request_body = { text: '...' }
      post '/v1/history/get_controlled_accounts',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'controlling_account is missing' }.to_json
      )
    end

    it 'returns 200 with accounts when there exists controlled accounts' do
      controlled_accounts = [
        {
          'controlled_account': 'controlled_acc_1',
          'controlled_permission': 'active',
          'controlling_account': 'controlling_acc'
        },
        {
          'controlled_account': 'controlled_acc_2',
          'controlled_permission': 'dev',
          'controlling_account': 'controlling_acc'
        }
      ]
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return(controlled_accounts)

      request_body = {
        controlling_account: 'controlling_acc'
      }
      post '/v1/history/get_controlled_accounts',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(controlled_accounts.to_json)
    end

    it 'returns 200 with empty array' do
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return([])

      request_body = {
        controlling_account: 'controlling_acc'
      }
      post '/v1/history/get_controlled_accounts',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq([].to_json)
    end
  end
end
