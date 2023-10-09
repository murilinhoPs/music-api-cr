require "uuid"
require "json"

struct Music
  include JSON::Serializable

  getter id : String, name : String, artist : String, album : String | Nil, length : Float64

  def initialize(@name, @artist, @length, *, @album = nil)
    @id = UUID.random.to_s # change for DB_id
  end

  # def initialize(pull : JSON::PullParser)

  #   @id = UUID.random.to_s
  # end

  def to_s : String
    "ID: #{id}\nName: #{name}\nArtist: #{artist}\nAlbum: #{album}\nDuration: #{length}"
  end
end
