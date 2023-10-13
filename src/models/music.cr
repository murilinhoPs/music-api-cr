require "uuid"
require "json"

struct Music
  include JSON::Serializable

  # @id : String = UUID.random.to_s
  getter id : String = UUID.random.to_s, # ? default value
    artist : String,
    album : String | Nil,
    length : Float64
  property name : String,
    favorite : Bool = false

  def initialize(@name, @artist, @length, *, @album = nil)
    @id = UUID.random.to_s # todo: change when generating from DB
  end

  def to_s : String
    "ID: #{id}\nName: #{name}\nArtist: #{artist}\nAlbum: #{album}\nDuration: #{length}"
  end
end
