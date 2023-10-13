require "kemal"
require "./models/music"
require "./utils"
include Utils

musics = [Music.new("musíca", "artista", 1.33, album: "album not nil")]

get "/" do |env|
  env.response.content_type = "application/json"
  env.response.status_code = 201

  {"message: ": "Hello World! Chegou status #{env.response.status_code}"}.to_json
end

get "/musics" do |env|
  musics.to_json
end

get "/musics/:id" do |env|
  id = env.params.url["id"]

  music = musics.find { |music| music.id == id }

  if !music
    error = {"message": "Error finding the music"}.to_json
    halt env, status_code: 404, response: error
  end

  music.to_json
end

get "/musics-quantity" do |env|
  env.response.status_code = 200
  {"message": "There are #{musics.size} music(s)"}.to_json
end

post "/musics" do |env|
  env.response.status_code = 201

  begin
    json_music = Music.from_json env.params.json.to_json
    musics << json_music

    {"message": "Música cadastrada com sucesso!",
     "ID":      "#{json_music.id}"}.to_json
  rescue ex
    formatted_exception = ex.message.not_nil!.split("\n")[0]
    error = {"message": formatted_exception}.to_json

    halt env, status_code: 400, response: error
  ensure
    Log.info { "Json received: #{env.params.json.to_json}" }.to_json
  end
end

patch "/musics/:id" do |env|
  music = valid_music? env.params.url["id"], musics
  if !music
    error = {"message": "Error finding the music"}.to_json
    halt env, status_code: 404, response: error
  end

  json_name = env.params.json["name"]?
  json_favorite = env.params.json["favorite"]?
  if !json_name && !json_favorite
    error = {"message": "No attributes to update passed to request json body"}.to_json
    halt env, status_code: 422, response: error
  end

  music_index = musics.index! music # * save the music index before update
  music.name = json_name.as(String)
  music.favorite = json_favorite.as(Bool)
  musics[music_index] = music # * update current music at its index

  Log.info {"Music index: #{musics.index!(music)}"}.to_json
  {"message": "Musica atualizada: #{music}"}.to_json
end

Kemal.run
