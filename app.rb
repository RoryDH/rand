require './models/rand_stat.rb'
require './helpers.rb'
require 'time'

# CONFIG
set :public_folder, File.dirname(__FILE__) + '/public'
helpers RH

# HOOKS
before do
  @client = request.env["REMOTE_ADDR"]

  if request.env["REQUEST_METHOD"] == "POST"
    request.body.rewind
    @rp = JSON.parse(request.body.read).symbolize_keys
  end


end

# ROUTES
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

post '/rs' do
  num = @rp[:num]

  if @rp[:j_time]
    begin
      @j_time = Time.parse @rp[:j_time]
    rescue ArgumentError => e
      return json(e "Invalid time")
    end
  end

  rs = RandStat.new(num: num, ip: @client, j_time: @j_time)
  if rs.save
    json(rs.for_api)
  else
    json(e rs.errors.full_messages)
  end
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