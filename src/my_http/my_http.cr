require "http/server"
require "http/client"
require "uuid"
require "../models/music.cr"

alias PostContext = String | Nil

module MyHTTP
  class BaseHttp
    def initialize
      @routes = {} of String => (-> String) | (-> Array(String)) | (-> Int32)
    end

    def start
      server = HTTP::Server.new do |ctx|
        request_pth = ctx.request.path.to_s
        if @routes.has_key?(request_pth)
          # body = ctx.request.body ? HTTP::Params.parse(ctx.request.body) : Nil
          ctx.response.content_type = "appliccation/json"
          ctx.response.print @routes[request_pth].call
        else
          ctx.response.status = HTTP::Status::NOT_FOUND
          ctx.response.print(ctx.response.status)
        end
      end
      address = server.bind_tcp 8000
      puts "Listening on http://#{address}"

      server.listen
    end

    def get(route : String, &block : -> _)
      @routes[route] = block
    end

    # (-> String | Array(String))

    # enviar na rota, o body da requisicao que vai ser um hash dinamico, vai executar o método que recebere &block
    # def post(route : String, &block : PostContext -> _)
    # end
  end
end

musics = [Music.new("musíca", "artista", album: "album not nil")]

app = MyHTTP::BaseHttp.new

app.get "/" do
  "hello world"
end

app.get "/musics" do
  musics.to_json
end

app.start

# serverEx = HTTP::Server.new do |context|
#   context.response.content_type = "text/plain"
#   context.response.print "Hello world! The time is #{Time.local}"
# end

# address = server.bind_tcp 8000

# puts "Listening on http://#{address}"
# server.listen
