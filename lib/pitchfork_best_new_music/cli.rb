class CLI

	BEST_NEW_ALBUMS_URL = "http://pitchfork.com/reviews/best/albums/"
	BEST_NEW_REISSUES_URL = "http://pitchfork.com/reviews/best/reissues/"
	BEST_NEW_TRACKS_URL = "http://pitchfork.com/reviews/best/tracks/"
	
	def run
		puts "Welcome to Pitchfork Best New Music!"
		make_best_new_albums
		make_best_new_reissues
		display_albums
	end

	def make_best_new_albums
		scraped_albums = Scraper.scraped_albums(BEST_NEW_ALBUMS_URL)
		Album.batch_create_from_review_collection(scraped_albums)
	end

	def make_best_new_reissues
		scraped_albums = Scraper.scraped_albums(BEST_NEW_REISSUES_URL)
		Reissue.batch_create_from_review_collection(scraped_albums)
	end

	def make_best_new_tracks
		scraped_albums = Scraper.scraped_albums(BEST_NEW_TRACKS_URL)
		Track.batch_create_from_review_collection(scraped_albums)
	end

	def display_albums
		Album.all.each_with_index do |album, index|
			puts "--- #{index+1} ---"
			puts "Album Title: #{album.album_title.upcase}"
			puts "Artist Name:" + " #{album.artist_name}"
			puts ""
		end
	end
	

end