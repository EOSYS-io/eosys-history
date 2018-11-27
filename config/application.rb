$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'history'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'boot'

Bundler.require(:default, ENV['RACK_ENV'])

['history'].each do |path|
  Dir[File.expand_path("../../#{path}/*.rb", __FILE__)].each do |f|
    require f
  end
end
