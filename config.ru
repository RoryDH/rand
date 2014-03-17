require 'rubygems'
require 'bundler'
Bundler.require

require "sinatra/json"

require './app.rb'
run Sinatra::Application