# gem to help access different URLs from inside command line 
require 'open-uri' 

# gem to read and search HTML of a webpage 
require 'nokogiri' 

url = "http://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters"
page = Nokogiri::HTML(open(url)) 

# pull all NBA team names 
# puts page.css('li.toclevel-3') 

# pull all player names
# puts page.css('td[style="text-align:left;"]')

# just grab player name 
# puts page.css('td[style="text-align:left;"]').text

#put it in a loop 
page.css('td[style="text-align:left;"]').each do |line| 
  puts line.text
end 