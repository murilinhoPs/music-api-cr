require "kemal"
require "./models/music"

musics = [Music.new("musíca", "artista", album: "album not nil")]

get "/" do |env|
  env.response.content_type = "application/json"
  env.response.status_code = 201

  {"message: ": "Hello World! Chegou status #{env.response.status_code}"}.to_json
end

get "/musics" do |env|
  musics.to_json
end

post "/musics" do |env|
  env.response.status_code = 201

  puts env.params.json
  {env.params.json}.to_json
end

Kemal.run
