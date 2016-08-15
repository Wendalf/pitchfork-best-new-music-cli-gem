class CLI

	BEST_NEW_ALBUMS_URL = "http://pitchfork.com/reviews/best/albums/"
	BEST_NEW_REISSUES_URL = "http://pitchfork.com/reviews/best/reissues/"
	BEST_NEW_TRACKS_URL = "http://pitchfork.com/reviews/best/tracks/"
	
	def run
		welcome
		scraping
		mainmenu
	end

	def scraping
		make_albums
		add_details_to_album_review
		make_tracks
		add_details_to_track_review
		make_reissues
		add_details_to_reissue_review
	end

	def welcome
		Catpix.print_image("/Users/Wenwen/Downloads/pitchfork-logo.png", options = {
				:resolution => "high"})
		puts ""
		puts "Welcome to Pitchfork Best New Music!"
	end

	def goodbye
		puts "Thank you for using Pitchfork Best New Music! See you next time!"
	end

#main-menu for the CLI
	def mainmenu
		puts "------- Main Menu -------"
		puts "-- 1. Best New Album --"
		puts "-- 2. Best New Track --"
		puts "-- 3. Best New Reissue --"
		puts "-- 4. Exit --".colorize(:red)
		puts "Enter 1-3 to get the list from pitchfork.com, enter 4 to Exit."
		input = gets.strip
		case input
			when "1"
				display_albums
				list_menu("Album")
			when "2"
				display_tracks
				list_menu("Track")
			when "3"
				display_reissues
				list_menu("Reissue")
			when "4"
				goodbye
			else
				puts "Invalid input.".colorize(:red) + " Please enter number 1-4."
				mainmenu
		end
	end

#sub-menu for each review class
	def list_menu(type)
		puts "---------- Best New #{type} Menu ----------"
		puts "1-24 -- Get individual review info."
		puts "b -- Go back to the main menu."
		input = gets.strip
		if input.to_i.between?(1,24)
			display_review_detail(type, input)
		elsif  input == "b"
			mainmenu
		else
			puts "Invalid input.".colorize(:red)
			list_menu(type)
		end
	end

	def display_review_detail(type, input)
		review = Object.const_get(type).find(input.to_i)
		#pass type as a string/argument to get the respective class name, and find the instance based on user's input number.
		case type
		when "Album"
			display_album_detail(review)
		when "Track"
			display_track_detail(review)
		when "Reissue"
			display_reissue_detail(review)
		end
		review_action(type, review)
	end

	def review_action(type, review)
		puts "----------------------------------------"
		puts "Would you like read the review in your browser and listen to the featured music? Enter y(yes) or n(no)."
		input = gets.strip
		case input
		when "y" || "yes"
			Launchy.open(review.review_url)
			review_sub_menu(type)
		when "n" || "no"
			review_sub_menu(type)
		else
			puts "Invalid input.".colorize(:red)
			review_action(type, review)
		end
	end

	def diplay_list_with_menu(type)
		case type
		when "Album"
			display_albums
		when "Track"
			display_tracks
		when "Reissue"
			display_reissues
		end
		
		list_menu(type)
	end

	def review_sub_menu(type)
		puts "l -- List Best New #{type} again."
		puts "b -- Go back to the main menu."
		puts "e -- Exit".colorize(:red)
		input = gets.strip
		case input
		when "l"
			diplay_list_with_menu(type)
		when "b"
			mainmenu
		when "e"
			goodbye
		else
			puts "Invalid input.".colorize(:red)
			review_sub_menu(type)
		end
	end

	#Making Albums and Albums' details. Display Album list and album details. 
	def make_albums
		scraped_albums = Scraper.scraped_albums(BEST_NEW_ALBUMS_URL)
		Album.batch_create_from_review_collection(scraped_albums)
	end

	def display_albums
		puts "------------ Best New Albums ------------"
		Album.all.each_with_index do |album, index|
			puts "#{index+1}. " + "#{album.album_title.upcase}".colorize(:blue) + " by " + "#{album.artist_name}".colorize(:light_blue)
		end
	end

	def add_details_to_album_review
		Album.all.each do |album|
			details = Scraper.scraped_album_review(album.review_url)
			album.add_review_details(details)
		end
	end

	def display_album_detail(review)
		puts ""
		puts "---------- " + "#{review.album_title.upcase}".colorize(:blue) + " ----------"
		puts "Artist Name: #{review.artist_name}"
		puts "Genre: #{review.genre}"
		puts "Reviewed " + "#{review.review_author}"
		puts "Introduction: #{review.deck}"
		puts "----------------------------------------".colorize(:blue)
		puts "#{review.paragraph.join("\n")}"
	end

	#Making Tracks and Tracks' details. Display track list and track details.
	def make_tracks
		scraped_tracks = Scraper.scraped_tracks(BEST_NEW_TRACKS_URL)
		Track.batch_create_from_review_collection(scraped_tracks)
	end

	def display_tracks
		puts "------------ Best New Tracks ------------"
		Track.all.each_with_index do |track, index|
			puts "#{index+1}. " + "#{track.track_title.upcase}".colorize(:blue) + " by " + "#{track.artist_name}".colorize(:light_blue)
		end
	end

	def add_details_to_track_review
		Track.all.each do |track|
			details = Scraper.scraped_track_review(track.review_url)
			track.add_review_details(details)
		end
	end

	def display_track_detail(review)
		puts ""
		puts "---------- " + "#{review.track_title.upcase}".colorize(:blue) + " ----------"
		puts "Artist Name: #{review.artist_name}"
		puts "Genre: #{review.genre}"
		puts "Reviewed " + "#{review.review_author}"
		puts "----------------------------------------".colorize(:blue)
		puts "#{review.paragraph.join("\n")}"
	end

	#Making Reissues and Reissues' details. Display reissue list and reissue details.
	def make_reissues
		scraped_reissues = Scraper.scraped_albums(BEST_NEW_REISSUES_URL)
		Reissue.batch_create_from_review_collection(scraped_reissues)
	end

	def display_reissues
		puts "------------ Best New Reissues ------------"
		Reissue.all.each_with_index do |reissue, index|
			puts "#{index+1}. " + "#{reissue.album_title.upcase}".colorize(:blue) + " by " + "#{reissue.artist_name}".colorize(:light_blue)
		end
	end

	def add_details_to_reissue_review
		Reissue.all.each do |reissue|
			details = Scraper.scraped_album_review(reissue.review_url)
			reissue.add_review_details(details)
		end
	end

	def display_reissue_detail(review)
		puts ""
		puts "---------- " + "#{review.album_title.upcase}".colorize(:blue) + " ----------"
		puts "Artist Name: #{review.artist_name}"
		puts "Genre: #{review.genre}"
		puts "Reviewed " + "#{review.review_author}"
		puts "Introduction: #{review.deck}"
		puts "----------------------------------------".colorize(:blue)
		puts "#{review.paragraph.join("\n")}"
	end

#CLI class end
end  