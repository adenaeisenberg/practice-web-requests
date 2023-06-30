require "http"

puts "Are you bored?"
user_input = gets.chomp

if user_input == "yes"
  puts "Why kind of acitivty are you in the mood of? You can choose: education, recreational, social, diy, charity, cooking, relaxation, music, busywork"
  activity_type = gets.chomp
  response = HTTP.get("http://www.boredapi.com/api/activity?type=#{activity_type}")
  activity = response.parse(:json)["activity"]
  num_participants = response.parse(:json)["participants"]
  accessibility = response.parse(:json)["accessibility"]

  puts "I have just the activity for you!"

  puts "This activity is #{activity}. This requires #{num_participants} participant(s). The accessibility of this activity, on a scale of 0.0-1.0 is #{accessibility}"
else
  puts "Ok good!"
end
