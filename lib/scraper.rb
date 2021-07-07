require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    doc.css(".student-card").each(){|student|
      student_info = {}
      student_info[:name] = student.css(".student-name").text
      student_info[:location] = student.css(".student-location").text
      student_info[:profile_url] = student.css("a").attribute("href").value
      students << student_info
    }
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    doc = Nokogiri::HTML(html)

    doc.css(".social-icon-container a").each(){|social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    }

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".description-holder p").text
    student_profile
  end

end
