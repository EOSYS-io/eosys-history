describe Api::V1::History::GetActions do
  include Rack::Test::Methods

  def app
    Api::V1::History::GetActions
  end

  context 'POST /v1/history/get_actions' do
    it 'returns 400 when there is no account_name field' do
      request_body = { text: '...' }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'account_name is missing' }.to_json
      )
    end

    it 'returns 400 with invalid account_name' do
      request_body = { account_name: 'INVALID' }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'account_name is invalid' }.to_json
      )
    end

    it 'returns 400 with invalid skip' do
      request_body = {
        account_name: 'validaccount',
        skip: -1
      }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'skip does not have a valid value' }.to_json
      )
    end

    it 'returns 400 with negative limit' do
      request_body = {
        account_name: 'validaccount',
        limit: -1
      }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'limit does not have a valid value' }.to_json
      )
    end

    it 'returns 400 with invalid limit' do
      request_body = {
        account_name: 'validaccount',
        limit: 3000
      }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'limit does not have a valid value' }.to_json
      )
    end

    it 'returns 400 with invalid sort' do
      request_body = {
        account_name: 'validaccount',
        sort: -2
      }
      post '/v1/history/get_actions',
           request_body.to_json,
           'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq(
        { error: 'sort does not have a valid value' }.to_json
      )
    end

    it 'returns 200 with actions' do
      actions = [
        {
          "receipt": {
            "receiver": 'eosyskoreabp',
            "act_digest": 'e9bbc2d73b804d701a59baed6e1f28e49d943599a7c1b694184b8e9b37e30924',
            "global_sequence": 895_484_762,
            "recv_sequence": 1987,
            "auth_sequence": [
              [
                'eosio.vpay',
                27_512
              ],
              [
                'eosyskoreabp',
                592
              ]
            ],
            "code_sequence": 2,
            "abi_sequence": 2
          },
          "act": {
            "account": 'eosio.token',
            "name": 'transfer',
            "authorization": [
              {
                "actor": 'eosio.vpay',
                "permission": 'active'
              },
              {
                "actor": 'eosyskoreabp',
                "permission": 'active'
              }
            ],
            "data": {
              "from": 'eosio.vpay',
              "to": 'eosyskoreabp',
              "quantity": '247.1034 EOS',
              "memo": 'producer vote pay'
            },
            "hex_data": '0080377503ea3055508f519742ec31557ab425000000000004454f53000000001170726f647563657220766f746520706179'
          },
          "context_free": false,
          "elapsed": 5,
          "console": '',
          "trx_id": '75daefe67dfffb957884f319c7b7003b39ebc485ebd428081b9e17366e85617e',
          "block_num": 23_732_463,
          "block_time": '2018-10-27T03:38:27.000',
          "producer_block_id": '016a20ef207e2c2509330b2eafd10d71acb5a729cd2efcaea881a6254a8a8363',
          "account_ram_deltas": [],
          "except": nil,
          "trx_status": 'executed'
        },
        {
          "receipt": {
            "receiver": 'eosio.vpay',
            "act_digest": 'e9bbc2d73b804d701a59baed6e1f28e49d943599a7c1b694184b8e9b37e30924',
            "global_sequence": 895_484_761,
            "recv_sequence": 19_525,
            "auth_sequence": [
              [
                'eosio.vpay',
                27_511
              ],
              [
                'eosyskoreabp',
                591
              ]
            ],
            "code_sequence": 2,
            "abi_sequence": 2
          },
          "act": {
            "account": 'eosio.token',
            "name": 'transfer',
            "authorization": [
              {
                "actor": 'eosio.vpay',
                "permission": 'active'
              },
              {
                "actor": 'eosyskoreabp',
                "permission": 'active'
              }
            ],
            "data": {
              "from": 'eosio.vpay',
              "to": 'eosyskoreabp',
              "quantity": '247.1034 EOS',
              "memo": 'producer vote pay'
            },
            "hex_data": '0080377503ea3055508f519742ec31557ab425000000000004454f53000000001170726f647563657220766f746520706179'
          },
          "context_free": false,
          "elapsed": 6,
          "console": '',
          "trx_id": '75daefe67dfffb957884f319c7b7003b39ebc485ebd428081b9e17366e85617e',
          "block_num": 23_732_463,
          "block_time": '2018-10-27T03:38:27.000',
          "producer_block_id": '016a20ef207e2c2509330b2eafd10d71acb5a729cd2efcaea881a6254a8a8363',
          "account_ram_deltas": [],
          "except": nil,
          "trx_status": 'executed'
        }
      ]
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return(actions)

      request_body = {
        account_name: 'eosyskoreabp',
        skip: 0,
        limit: 2
      }
      post '/v1/history/get_actions',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ actions: actions }.to_json)
    end

    it 'returns 200 with empty array' do
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers).to receive(:find).and_return([])

      request_body = {
        account_name: 'acc'
      }
      post '/v1/history/get_actions',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ actions: [] }.to_json)
    end
  end
end
