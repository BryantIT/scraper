require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "https://www.indeed.com/jobs?q=&l=Dickson%2C+TN"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  job_listings = parsed_page.css('div.jobsearch-SerpJobCard')
  job_listings.each do |j|
    job = {
      title: job_listings.css('h2.title').text,
      company: job_listings.css('a.turnstileLink').text,
      location: job_listings.css('div.location').text,
      description: job_listings.css('div.summary').text,

    }
    byebug
  end
end

scraper
