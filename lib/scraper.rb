require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(html)
    site = Nokogiri::HTML(open(html))
    
    students = []
    
    #student: "div.student-card"
    #name: student.css("a div.card-text-container h4").text
    #location: student.css("a div.card-text-container p").text
    #profile_url: student.css("a").attribute("href").value
    
    site.css("div.student-card").each do |profile| 
    student = {
      :name => profile.css("a div.card-text-container h4").text,
      :location => profile.css("a div.card-text-container p").text,
      :profile_url => profile.css("a").attribute("href").value
    }
    students << student
  end
  students
  end

  def self.scrape_profile_page(html)
    site = Nokogiri::HTML(open(html))
    
    student = {}
    
    student[:profile_quote] = site.css("div.profile-quote").text
    student[:bio] = site.css("div.description-holder p").text
    
    site.css("div.social-icon-container a").each do |sic|
      url = sic.attribute("href").value
      if url.include? "twitter"
        student[:twitter] = url
      elsif url.include? "linkedin"
        student[:linkedin] = url
      elsif url.include? "github"
        student[:github] = url
      else
        student[:blog] = url
      end #elsif test
    end #each loop
    student
  end #scrape_profile_page
end #scraper

