require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require File.expand_path('history/api', File.dirname(__FILE__))

run History::Api
