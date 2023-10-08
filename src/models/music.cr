require "uuid"
require "json"

struct Music
  include JSON::Serializable

  getter id : String, name : String, artist : String, album : String | Nil, length : Float64

  def initialize(@name, @artist, *, @album = nil)
    @id = UUID.random.to_s # change for DB_id
    @length = Random.rand(2.8)
  end

  def to_s : String
    "ID: #{id}\nName: #{name}\nArtist: #{artist}\nAlbum: #{album}\nDuration: #{length}"
  end
end
