class PitchforkBestNewMusic::Scraper

	def self.scrape_albums_page(album_list_url)
		# album_list_url = "http://pitchfork.com/reviews/best/albums/"
		page = Nokogiri::HTML(open(album_list_url))
		albums = page.css("div.fragment-list div.review")
		scraped_albums = []
		# artist_name: album.css("a div.album-artist ul.artist-list li").text
    	# album_title: album.css("a div.album-artist h2.title").text
    	# genre: album.css("div.meta ul.genre-list li a").text
    	# review_author: album.css("div.meta ul.authors li a").text.gsub("by: ", "")
    	# review_url: "http://pitchfork.com" + album.css("a").attribute("href").value
		# binding.pry
		albums.each do |album|
			single_album_hash = {
				artist_name: album.css("a div.album-artist ul.artist-list li").text,
				album_title: album.css("a div.album-artist h2.title").text,
				genre: album.css("div.meta ul.genre-list li a").text,
				review_author: album.css("div.meta ul.authors li a").text.gsub("by: ", ""),
				review_url: "http://pitchfork.com" + album.css("a").attribute("href").value
			}
			scraped_albums << single_album_hash
		end
		scraped_albums
		# scraped_albums.each_with_index do |single_album_hash, index|
		# 	puts "#{index+1}. #{single_album_hash}"
		# end
	end




end