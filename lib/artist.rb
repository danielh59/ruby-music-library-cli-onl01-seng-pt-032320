require 'pry'
class Artist
  extend Concerns::Findable
  attr_accessor :name, :song, :genre

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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

  def self.create(artist)
  artist = Artist.new(artist)
  artist.save
  artist
  end

    def add_song(song)
if song.artist == nil
  song.artist = self
end
if !@songs.include?(song)
  @songs << song
    end
end

  def songs
 @songs
  end

def genres
  songs.collect{|song| song.genre}.uniq
end



end
