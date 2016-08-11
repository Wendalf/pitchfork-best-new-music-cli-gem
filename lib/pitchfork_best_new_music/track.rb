class Track
	
	attr_accessor :artist_name, :track_title, :genre, :review_author, :review_url

	@@all = []

	def self.all
		@@all
	end

	def self.batch_create_from_tracks_collection(scraped_tracks)
		scraped_tracks.each do |single_track_hash|
			self.new(single_track_hash)
		end
	end

	def initialize(single_track_hash)
		single_track_hash.each do |key, value|
			self.send("#{key}=", value)
		end
		@@all << self
	end




end