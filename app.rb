require 'sinatra'
require 'sinatra/activerecord'
set :database_file, "./config/database.yml"

require './models/rand_stat.rb'
require './models/user.rb'
require './helpers.rb'
require 'time'

# CONFIG
helpers RH
sess_secret = ENV['SESS_SECRET'] || "much1random2wow3"

set :session_secret, sess_secret
set :public_folder, File.dirname(__FILE__) + '/public'

enable :sessions
enable :logging

# HOOKS
before do
  @client = request.ip

  if request.post?
    request.body.rewind
    b = request.body.read
    @rp = b.size > 0 ? JSON.parse(b).symbolize_keys : {}
  end

  @u = User.find(session[:u]) if session[:u] #Find if there is a user_id stored in session
  unless @u # If could not find user OR no session[:u] at all
    @u = User.create()
    session[:u] = @u.id
    @new_user = true
  end
  puts "User id: #{@u.id}"

  @ua = request.user_agent
end

# ROUTES
# get '/' do
#   send_file File.join(settings.public_folder, 'index.html')
# end

post '/rs' do
  num = @rp[:num]

  if @rp[:j_time]
    begin
      @j_time = Time.parse @rp[:j_time]
    rescue ArgumentError => e
      return json(e "Invalid time")
    end
  end

  rs = RandStat.new(
    user: @u,
    num: num,
    ip: @client,
    j_time: @j_time,
    user_agent: @ua
  )
  if rs.save
    json(rs.for_api)
  else
    status 400
    json(e rs.errors.full_messages)
  end
end

post '/u' do
  h = @u.for_api
  h[:new] = @new_user
  json h
end

# ERRORS
not_found do
  json({ httperror: ["Not found"] })
end

private

  def e(msgs)
    msgs = [msgs] unless msgs.is_a? Array
    { errors: msgs }
  end