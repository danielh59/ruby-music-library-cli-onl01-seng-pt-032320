class MusicImporter

  def initialize(path)
    @path = path
  end

  def path
    @path
  end

  def files()
    @files ||= Dir.glob("#{@path}/*.mp3").collect{ |file| file.gsub("#{@path}/", "") }
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
  def self.new_from_filename(file)
     file_array = file.split(" - ")

     songn = file_array[1]
     artistn= file_array[0]
     genren = file_array[2].split(".mp3").join

     artist = Artist.find_or_create_by_name(artistn)
     genre = Genre.find_or_create_by_name(genren)
     self.new(songn, artist, genre)
   end
end
