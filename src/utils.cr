require "./models/music"


module Utils
  def valid_music?(id, musics : Array(Music))
    music = musics.find { |music| music.id == id }
    if !music
      false
    end
    music
  end
end
