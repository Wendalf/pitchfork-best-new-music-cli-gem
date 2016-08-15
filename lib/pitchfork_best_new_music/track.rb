class Track
	
	extend Review::ClassMethods
	include Review::InstanceMethods

	attr_accessor :artist_name, :track_title, :genre, :review_author, :review_url, :paragraph

	@@all = []

	def initialize(single_album_hash)
		single_album_hash.each do |key, value|
			self.send("#{key}=", value)
		end
		@@all << self
	end

	def self.all
		@@all
	end

end