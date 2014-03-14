require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  "the time where this server lives is #{Time.now}
    <br /><br />check out youpr <a href=\"/agent\">user_agent</a>"
end

get '/agent' do
  "you're npg #{request.user_agent}"
end