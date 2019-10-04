
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    doc = Nokogiri::HTML(html)
    students = doc.css("div.roster-cards-container")
    # student_loc = doc.css("p.student-location")
    # student_profile = doc.attr("href")
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
    
  end

end

