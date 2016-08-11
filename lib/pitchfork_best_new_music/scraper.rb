class PitchforkBestNewMusic::Scraper

	def self.scrape_albums_page(album_list_url)
		# album_list_url = "http://pitchfork.com/reviews/best/albums/"
		page = Nokogiri::HTML(open(album_list_url).read, nil, 'utf-8')
		albums = page.css("div.fragment-list div.review")
		scraped_albums = []
		# artist_name: album.css("a div.album-artist ul.artist-list li").text
    	# album_title: album.css("a div.album-artist h2.title").text
    	# genre: album.css("div.meta ul.genre-list li a").text
    	# review_author: album.css("div.meta ul.authors li a").text.gsub('by: ', '')
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
		# scraped_albums
		scraped_albums.each_with_index do |single_album_hash, index|
			puts "#{index+1}. #{single_album_hash}"
		end
	end

	def self.scrape_tracks_page_featured_track(page)	
		featured_track = page.css("div.track-hero")
		# artist_name: featured_track.css("div.track-details a.title-link ul.artist-list li").text
		# track_title: featured_track.css("div.track-details a.title-link h2.title").text.gsub(/[“”]/, '')
		# genre: featured_track.css("div.meta ul.genre-list.before li a").text
		# review_author: featured_track.css("div.meta ul.authors li a").text.gsub('by: ', '')
		# review_url: "http://pitchfork.com" + featured_track.css("div.track-details a.title-link").attribute("href").value
		# binding.pry
		featured_track_hash = {
				artist_name: featured_track.css("div.track-details a.title-link ul.artist-list li").text,
				track_title: featured_track.css("div.track-details a.title-link h2.title").text.gsub(/[“”]/, ''),
				genre: featured_track.css("div.meta ul.genre-list.before li a").text,
				review_author: featured_track.css("div.meta ul.authors li a").text.gsub('by: ', ''),
				review_url: "http://pitchfork.com" + featured_track.css("div.track-details a.title-link").attribute("href").value
		}
	end

	def self.scrape_tracks_page_listed_tracks(page)
		tracks = page.css("div.track-collection-item")
		# artist_name: track.css("div.track-details div.row a.track-link ul.artist-list li").text
		# track_title: track.css("div.track-details div.row a.track-link h2").text.gsub(/[“”]/, '')
		# genre: track.css("div.track-details div.row div.track-meta ul.genre-list.before li a").text
		# review_author: track.css("div.track-details div.row div.track-meta div.publish-info ul.authors li a.linked.display-name").text.gsub('by: ', '')
		# review_url: "http://pitchfork.com" + track.css("div.track-details div.row a.track-link").attribute("href").value
		# binding.pry
		tracks.collect do |track|
			single_track_hash = {
				artist_name: track.css("div.track-details div.row a.track-link ul.artist-list li").text,
				track_title: track.css("div.track-details div.row a.track-link h2").text.gsub(/[“”]/, ''),
				genre: track.css("div.track-details div.row div.track-meta ul.genre-list.before li a").text,
				review_author: track.css("div.track-details div.row div.track-meta div.publish-info ul.authors li a.linked.display-name").text.gsub('by: ', ''),
				review_url: "http://pitchfork.com" + track.css("div.track-details div.row a.track-link").attribute("href").value
			}
		end
	end

	def self.scrape_tracks_page(track_list_url)
		# track_list_url = "http://pitchfork.com/reviews/best/tracks/"
		page = Nokogiri::HTML(open(track_list_url).read, nil, 'utf-8')
		scraped_tracks = []
		scraped_tracks << self.scrape_tracks_page_featured_track(page)
		scraped_tracks << self.scrape_tracks_page_listed_tracks(page)
		scraped_tracks.flatten
		# scraped_tracks.flatten!.each_with_index do |single_track_hash, index|
		# 	puts "#{index+1}. #{single_track_hash}"
		# end
	end

	def self.scrape_album_review_page(album_review_url)
		album_review_doc = Nokogiri::HTML(open(album_review_url).read, nil, 'utf-8')
		review = album_review_doc.css("div.article-content")
		binding.pry
		# deck:

	end



end