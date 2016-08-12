Four main Classes: CLI, Scraper, Album, Track
One Module: Review


I. CLI is responsible for
 
1. - display the welcome message.
   - provide user a menu to access the reviews for best new music, and the option to exit the data gem.
   - MENU
      1. Best New Album(albums)
      2. Best New Track(tracks)
      3. Best New Reissue(albums)
      4. exit
   - asks user’s input for choose an option
   - outputs “invalid input” and asks for the user’s input again when user enter an invalid input other than the menu options given before.
   - display the goodbye message.

2. - list the albums or tracks under the user’s chosen option.
   - list albums or tracks by ordered number, and the option to exit back to the main menu of the data gem.
   - MENU
      1. music list(either album title or track title)
      .
      .
      .
      25. exit back to the main menu
   - asks user’s input to access the detail of the music’s review.
   - outputs “invalid input” and asks for the user’s input again when user enter an invalid input other the number of the music review or exit back to main menu.

3. - display details(attributes) of this music review, including title, artist name, genre, review author, etc.
   - display introduction/headline of the music review.
   - display the first paragraph of the review.
   - asks user’s input to access the whole review/listen to the featured tracks, back to the music list, or exit gem.
   - MENU
      1. launchy the review web page
      2. back to the music list
      3. exit gem
   - outputs “invalid input” and asks for the user’s input again when user enter an invalid input other the menu options.


II. Scraper is responsible for

1. Scrape the album list pages(new or reissue), and return the albums array.

2. Scrape the track list page, and return the tracks array.

3. Scrape the album review page, and return the album review hash with details/attributes.

4. Scrape the track review page, and return the track review hash with details/attributes.


III. Review is responsible for

1. batch create album/track instances from the given data collection. 

2. adds review page details(attributes) to the either album or track instance.

IV. Album is responsible for

1. makes an album review instance. When an album instance initialize, use mass assignment to give the instance keys and values, save the instance to the class variable @@all.

2. keeps track of all the album review instances that has been created. Album class @@all array is accessible by the CLI class.


V. Track is responsible for

1. makes an track review instance. When an track instance initialize, use mass assignment to give the instance keys and values, save the instance to the class variable @@all.

2. keeps track of all the track review instances that has been created. Track class @@all array is accessible by the CLI class.




