module Concerns::Findable

  def find_by_name(a_song)
  all.detect{|x| x.name == a_song}
  end

  def find_or_create_by_name(song)
    find_by_name(song) || self.create(song)
  end

end
