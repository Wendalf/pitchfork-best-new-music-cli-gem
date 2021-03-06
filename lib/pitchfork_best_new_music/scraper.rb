class Scraper

# scraping method for both Best New Album and Best New Reissue page.
	def self.scraped_albums(album_list_url)
		page = Nokogiri::HTML(open(album_list_url).read, nil, 'utf-8')
		albums = page.css("div.fragment-list div.review")
		scraped_albums = []
		albums.each do |album|
			single_album_hash = {
				artist_name: album.css("a div.album-artist ul.artist-list li").text,
				album_title: album.css("a div.album-artist h2.title").text.gsub(/^\s|\s$/, ''),
				genre: album.css("div.meta ul.genre-list li a").text,
				review_author: album.css("div.meta ul.authors li a").text,
				review_url: "http://pitchfork.com" + album.css("a").attribute("href").value
			}
			scraped_albums << single_album_hash
		end
		scraped_albums
	end

# scraping method for the top featured track located apart from the rest of the listed tracks on the Best New Tracks page.
	def self.scraped_featured_track(page)	
		featured_track = page.css("div.track-hero")
		scraped_featured_track = {
				artist_name: featured_track.css("div.track-details a.title-link ul.artist-list li").text,
				track_title: featured_track.css("div.track-details a.title-link h2.title").text.gsub(/[“”]/, ''),
				genre: featured_track.css("div.meta ul.genre-list.before li a").text,
				review_author: featured_track.css("div.meta ul.authors li a").text,
				review_url: "http://pitchfork.com" + featured_track.css("div.track-details a.title-link").attribute("href").value
		}
	end

# scraping method for the listed tracks on the Best New Tracks page.
	def self.scraped_listed_tracks(page)
		tracks = page.css("div.track-collection-item")
		scraped_listed_tracks = []
		tracks.each do |track|
			single_track_hash = {
				artist_name: track.css("div.track-details div.row a.track-link ul.artist-list li").text,
				track_title: track.css("div.track-details div.row a.track-link h2").text.gsub(/[“”]/, ''),
				genre: track.css("div.track-details div.row div.track-meta ul.genre-list.before li a").text,
				review_author: track.css("div.track-details div.row div.track-meta div.publish-info ul.authors li a.linked.display-name").text,
				review_url: "http://pitchfork.com" + track.css("div.track-details div.row a.track-link").attribute("href").value
			}
			scraped_listed_tracks << single_track_hash
		end
		scraped_listed_tracks
	end

# return a scraped tracks array from the scraped Best New Tracks page.
	def self.scraped_tracks(track_list_url)
		page = Nokogiri::HTML(open(track_list_url).read, nil, 'utf-8')
		scraped_tracks = self.scraped_listed_tracks(page)
		scraped_tracks.unshift(self.scraped_featured_track(page))
		scraped_tracks
		# scraped_tracks = []
		# scraped_tracks << self.scrape_tracks_page_featured_track(page)
		# scraped_tracks << self.scrape_tracks_page_listed_tracks(page)
		# scraped_tracks.flatten!
	end

# scraping method for both detailed Album review and detailed Reissue review page.
	def self.scraped_album_review(album_review_url)
		album_review_doc = Nokogiri::HTML(open(album_review_url).read, nil, 'utf-8')
		review = album_review_doc.css("div.article-content")
		paragraph = review.css("div.contents p").map{|p| p.text + "\n"}

		scraped_album_review_hash = {
			deck: review.css("div.abstract p").text,
			paragraph: paragraph
		}
	end

# scraping method for both detailed Track review page.
	def self.scraped_track_review(track_review_url)
		track_review_doc = Nokogiri::HTML(open(track_review_url).read, nil, 'utf-8')
		review = track_review_doc.css("div.review-copy-container")
		paragraph = review.css("div.review-copy div.contents p").map{|p| p.text + "\n"}

		scraped_track_review_hash = {paragraph: paragraph}
	end

end