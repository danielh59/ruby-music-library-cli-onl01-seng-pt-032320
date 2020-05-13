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
   file_array= file.split(" - ")

   artistn = file_array[0]
   songn = file_array[1]
   genren = file_array[2].split(".mp3").join

   artist = Artist.find_or_create_by_name(artisn)
   genre = Genre.find_or_create_by_name(genren)
   self.new(songn, artist, genre)
 end

end
