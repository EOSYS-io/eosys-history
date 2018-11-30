module Api
  module Helper
    module MongoHelpers
      include Mongo

      @@client = Client.new(
        ['mongodb.eosys.io:27017'],
        database: 'eos',
        user: ENV['MONGODB_USER'],
        password: ENV['MONGODB_PASSWORD'],
        auth_source: 'admin',
        max_pool_size: 5,
        connect: :direct
      )

      def self.get_collection(collection_name)
        @@client[collection_name]
      end

      def self.find(collection_name, filter, options)
        JSON.parse(@@client[collection_name].find(filter, options).to_a.to_json)
      end

      def self.find_one(collection_name, filter, options)
        @@client[collection_name].find(filter, options).first
      end
    end
  end
end
