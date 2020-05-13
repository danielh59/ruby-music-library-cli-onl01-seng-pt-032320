class Song
attr_accessor :name,:artist, :genre
extend Concerns::Findable

  @@all = []


def initialize(name, artist = nil, genre = nil)
  @name = name
 self.artist = artist if artist
 self.genre = genre if genre
end

def save
@@all << self
end

def self.all
  @@all
end

def self.destroy_all
@@all.clear
end

def self.create(song)
song = Song.new(song)
song.save
song
end

def artist=(artist)
  @artist = artist
  self.artist.add_song(self)
end

def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
end

def self.find_by_name(a_song)
@@all.detect{|x| x.name == a_song}
end

def self.find_or_create_by_name(song)
  self.find_by_name(song) || self.create(song)
end

def self.new_from_filename(file)
   song_array = file.split(" - ")

   song_name = song_array[1]
   artist_name = song_array[0]
   genre_name = song_array[2].split(".mp3").join

   artist = Artist.find_or_create_by_name(artist_name)
   genre = Genre.find_or_create_by_name(genre_name)
   self.new(song_name, artist, genre)
 end

 def self.create_from_filename(filename)
   self.new_from_filename(filename).save
 end

 def save
   @@all << self
 end

end
