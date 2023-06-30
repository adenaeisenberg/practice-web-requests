# Exercise: Build a terminal dictionary app
# Create a new ruby file called dictionary_app.rb
# The program should ask the user to enter a word, then use the wordnik API to show the word’s definition: https://developer.wordnik.com/docs#!/word/getDefinitions
# Once that works, have it also display the top example and pronunciation (browse through the documentation to the top example and pronunciation).

while true
  require "http"
  require "open-uri"

  print "Enter a word: "
  word = gets.chomp

  if word == "q"
    break
  else
    response = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=API KEY")
    p response.parse[1]["text"]
    puts "\n"

    example = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/examples?includeDuplicates=false&useCanonical=false&limit=5&api_key=API KEY")
    pp example.parse["examples"][0]["text"]
    puts "\n"

    pronunciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=API KEY")
    pp pronunciation.parse[0]["raw"]

    audio = HTTP.get("https://api.wordnik.com/v4/word.json/#{word}/audio?useCanonical=false&limit=50&api_key=API KEY")

    # p audio.parse[0]["fileUrl"]
    URI.open(audio.parse[0]["fileUrl"]) { |f|
      f.each_line { |line| p line }
    }
  end
end
# Bonus: Search for the audio section in the documentation. Use wordnik’s audio api to get the first fileUrl to open in the browser (you’ll need to google this!) and pronounce the name of the word.
