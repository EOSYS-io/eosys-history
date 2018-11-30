describe Api::V1::History::GetTransaction do
  include Rack::Test::Methods

  def app
    Api::V1::History::GetTransaction
  end

  context 'POST /v1/history/get_transaction' do
    it 'returns 400 when there is no id field' do
      request_body = { text: '...' }
      post '/v1/history/get_transaction',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(400)
      expect(last_response.body).to eq({ error: 'id is missing' }.to_json)
    end

    it 'returns 200 with null when there is no matched transaction' do
      request_body = { id: 'SOME_ID' }
      allow(Api::Helper::MongoHelpers)
        .to receive(:find_one)
        .and_return(nil)
      post '/v1/history/get_transaction',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'

      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(nil.to_json)
    end

    it 'returns 200 with valid request' do
      transaction = {
        "id": '708f08725f1e7f86670a3e4f5e01f8833df875b5949513643a0a362e3c6ac75f',
        "block_num": 132,
        "block_time": '2018-06-09T11:57:35.000',
        "producer_block_id": '00000084fb5e3385d2d39f817f77c639361071dbf215934222765eee39eaab2d',
        "receipt": {
          "status": 'executed',
          "cpu_usage_us": 380,
          "net_usage_words": 25

        },
        "elapsed": 228,
        "net_usage": 200,
        "scheduled": false,
        "action_traces": [
          {
            "receipt": {
              "receiver": 'eosio',
              "act_digest": 'd783c39b268384baee72b3adcf928c42c6a0e466ec41913378e615793bdc2fb5',
              "global_sequence": 134,
              "recv_sequence": 134,
              "auth_sequence": [
                [
                  'eosio',
                  134
                ]
              ],
              "code_sequence": 1,
              "abi_sequence": 1
            },
            "act": {
              "account": 'eosio',
              "name": 'newaccount',
              "authorization": [
                {
                  "actor": 'eosio',
                  "permission": 'active'
                }
              ],
              "data": {
                "creator": 'eosio',
                "name": 'eosio.msig',
                "owner": {
                  "threshold": 1,
                  "keys": [
                    {
                      "key": 'EOS7EarnUhcyYqmdnPon8rm7mBCTnBoot6o7fE2WzjvEX2TdggbL3',
                      "weight": 1
                    }
                  ],
                  "accounts": [],
                  "waits": []
                },
                "active": {
                  "threshold": 1,
                  "keys": [
                    {
                      "key": 'EOS7EarnUhcyYqmdnPon8rm7mBCTnBoot6o7fE2WzjvEX2TdggbL3',
                      "weight": 1
                    }
                  ],
                  "accounts": [],
                  "waits": []
                }
              },
              "hex_data": '0000000000ea30550000735802ea305501000000010003350529efca8c607421e95846cc2a3d2efaa8454018deb75a204e27acf29ee5cc0100000001000000010003350529efca8c607421e95846cc2a3d2efaa8454018deb75a204e27acf29ee5cc01000000'
            },
            "context_free": false,
            "elapsed": 47,
            "console": '',
            "trx_id": '708f08725f1e7f86670a3e4f5e01f8833df875b5949513643a0a362e3c6ac75f',
            "block_num": 132,
            "block_time": '2018-06-09T11:57:35.000',
            "producer_block_id": '00000084fb5e3385d2d39f817f77c639361071dbf215934222765eee39eaab2d',
            "account_ram_deltas": [
              {
                "account": 'eosio.msig',
                "delta": 2724
              }
            ],
            "except": nil,
            "inline_traces": []
          }
        ],
        "except": nil
      }
      # Mocking mongodb response.
      allow(Api::Helper::MongoHelpers)
        .to receive(:find_one)
        .and_return(transaction)

      request_body = {
        id: '708f08725f1e7f86670a3e4f5e01f8833df875b5949513643a0a362e3c6ac75f'
      }
      post '/v1/history/get_transaction',
           request_body.to_json, 'CONTENT_TYPE' => 'application/json'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq(transaction.to_json)
    end
  end
end
