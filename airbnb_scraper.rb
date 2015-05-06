require 'open-uri' 
require 'nokogiri' 
require 'csv' 

#store URL to be scraped 
url = "https://www.airbnb.com/s/Kirkland--WA--United-States"

# parse page with Nokogiri 
page = Nokogiri::HTML(open(url))

#scrape max num of pages and store in max page variable 
page_numbers = []



page.css("div.pagination ul li a[target]").each do |line| 
  page_numbers << line.text 
end 

max_page = page_numbers.max

# initialize empty arrays 
name = []
price = []
details = []

max_page.to_i.times do |i| 

  url = "https://www.airbnb.com/s/Kirkland--WA--United-States?page=#{i+1}"
  page = Nokogiri::HTML(open(url)) 

  #store data in arrays 

  page.css("h3").each do |line| 
    name << line.text.strip 
  end 

 
  page.css('span.h3.price-amount').each do |line| 
    price << line.text
  end


  page.css('div.text-muted.listing-location.text-truncate').each do |line| 
    subarray = details << line.text.strip.split(/     · / && /   · /)

    if subarray.length == 3
      details << subarray 
    else 
      dteails << [subarray[0], "0 reviews", subarray[1]]
    end 
  end 

  #write data to CSV file 
  CSV.open("airbnb_listings.csv", "w") do |file| 
    file << ["Listing Name", "Price", "Room Type", "Reviews", "Location"]
    name.length.times do |i| 
      file << [name[i], price[i], details[i][0], details[i][1], details[i][2]]
    end 
  end 
end 