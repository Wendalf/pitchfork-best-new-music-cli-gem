module Review
	
	module ClassMethods
		def self.batch_create_from_review_collection(scraped_reviews_collection)
			scraped_reviews_collection.each do |single_review_hash|
				self.new(single_review_hash)
			end
		end
	end

	module InstanceMethods
		def add_review_details(review_detail_hash)
			review_detail_hash.each do |key, value|
				self.send("#{key}=", value)
			end
			self
		end
	end

end