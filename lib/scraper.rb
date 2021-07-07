require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
    students = doc.css("div.roster-cards-container")
    student_hash = []

    students.each do |student|
      student.css("div.student-card a").each do |html|
        student_name = html.css("h4.student-name").text
        student_loc = html.css("p.student-location").text
        
        student_profile = html.attr("href")
        student_hash << {
          :name => student_name,
          :location => student_loc,
          :profile_url => student_profile
        }
      end
  end
  student_hash
end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    social_url = doc.css("div.social-icon-container a")
    student = {}
    social_url.each do |a|
      if a.attributes["href"].value.include?("twitter")
        student[:twitter] = a.attributes["href"].value
      elsif a.attributes["href"].value.include?("linkedin")
        student[:linkedin] = a.attributes["href"].value
      elsif a.attributes["href"].value.include?("github")
        student[:github] = a.attributes["href"].value
      else
        student[:blog] = a.attributes["href"].value
      end
      student[:profile_quote] = doc.css("div.profile-quote").text.chomp
      student[:bio] = doc.css("div.description-holder p").text
    end
  student
  end
end