require 'rubygems'
require 'bundler'
Bundler.require

require "sinatra/json"
require "./config/nobrainer.rb"

require './app.rb'
run Sinatra::Application