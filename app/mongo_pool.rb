module App
  class MongoPool
    include Mongo

    @@client = Client.new(
      ['mongodb.eosys.io:27017'],
      database: 'eos',
      user: ENV['MONGODB_USER'],
      password: ENV['MONGODB_PASSWORD'],
      auth_source: 'admin',
      :max_pool_size => 5,
      :connect => :direct
    )

    def self.get_collection(collection_name)
      @@client[collection_name]
    end
  end
end
