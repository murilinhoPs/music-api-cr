require "http/client"
require "kemal"

BASE_URL = "localhost:8000"

def req
  res = HTTP::Client.get "#{BASE_URL}/musics"
  puts res.status_code
  puts res.body
end

req()

# post "/pessoas" do |env|
#   env.response.status_code = 201
# end
