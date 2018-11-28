$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'history'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'boot'

Bundler.require(:default, ENV['RACK_ENV'])

# To avoid using pattern like **/*.rb,
# include all directories containing rb files explicitly.
['api/v1/history/eosio_history_api', 'api/v1/history', 'api', 'app'].each do |path|
  Dir[File.expand_path("../../#{path}/*.rb", __FILE__)].each do |f|
    require f
  end
end

Mongo::Logger.logger.level = Logger::WARN
