class Album
	
	attr_accessor :artist_name, :album_title, :genre, :review_author, :review_url

	@@all = []

	def self.all
		@@all
	end

	def self.batch_create_from_albums_collection(scraped_albums)
		scraped_albums.each do |single_album_hash|
			self.new(single_album_hash)
		end
	end

	def initialize(single_album_hash)
		single_album_hash.each do |key, value|
			self.send("#{key}=", value)
		end
		@@all << self
	end




end