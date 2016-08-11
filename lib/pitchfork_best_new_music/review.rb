class Review
	
	attr_accessor :artist_name, :album_title, :track_title, :genre, :review_author, :review_url

	@@all = []

	def self.all
		@@all
	end

	def self.batch_create_from_review_collection(scraped_reviews_collection)
		scraped_reviews_collection.each do |single_review_hash|
			self.new(single_review_hash)
		end
	end

	def initialize(single_review_hash)
		single_review_hash.each do |key, value|
			self.send("#{key}=", value)
		end
		@@all << self
	end




end