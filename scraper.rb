require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "https://www.indeed.com/jobs?q=&l=Dickson%2C+TN&sort=date"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  jobs = Array.new
  job_listings = parsed_page.css('div.jobsearch-SerpJobCard')
  job_listings.each do |j|
    job = {
      title: j.css('h2.title').text.gsub(/["\"","\n"]/, ''),
      company: j.css('span.company').text.gsub(/["\"","\n"]/, ''),
      location: j.css('div.location').text,
      description: j.css('div.summary').text.gsub(/["\"","\n"]/, ''),
    }
    jobs << job
    byebug
  end
end

scraper
