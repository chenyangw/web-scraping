#
# OSU Job Scraper
#
# The program scrapes jobsatosu.com for the
# following job listings:
#
# 1. Search term "Developer"
# 2. Job category "Information Technology"
# 3. Search term "CSS"
#
# @author: Tania Prince, Chenyang Wang, Dragan Pantic, 
# Cameron Mitchell, and Daniel White 
#

# Web Scraper ------------------------------------------------------------

# Enter the following command to install the nokogiri gem:
# > gem install nokogiri

require "rubygems"
require "nokogiri"
require "open-uri"

# Search term "developer"
developer = 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93' \
            '&query=developer&query_v0_posted_at_date=&591=&577=&578=' \
            '&579=&580=&581=&commit=Search'

# Job category "Information Technology"
informationTechnology = 'https://www.jobsatosu.com/postings/search?ut' \
            'f8=%E2%9C%93&query=&query_v0_posted_at_date=&591=&577=&5' \
            '78=&579=&580=4&581=&commit=Search'

# Search term "css"
css = 'https://www.jobsatosu.com/postings/search?utf8=%E2%9C%93&query' \
            '=css&query_v0_posted_at_date=&591=&577=&578=&579=&580=&5' \
            '81=&commit=Search'

# Methods ----------------------------------------------------------------

# Displays job list
def printJobList(html)

	jobs = html.css('.job-item.job-item-posting')

	jobs.each do |job|
	    
	    #position title 
	    puts "Position Title: #{job.at_css('td:first-child').text.strip}"

	    #working title
	    puts "Working Title: #{job.at_css('td:nth-child(2)').text.strip}"

	    #department
	    puts "Department: #{job.at_css('td:nth-child(3)').text.strip}"

	    #application deadline
	    puts "Application Deadline: #{job.at_css('td:nth-child(4)').text.strip}"
	    
	    #target salary
	    puts "Salary: #{job.at_css('td:nth-child(6)').text.strip}"

	    #job description
	    puts "Description: #{job.at_css('.job-description').text.strip}"

	    #spacing
	    puts ""
	    puts "------------------------------------------------------------"
	    puts ""
	end

end

# Main -------------------------------------------------------------------

input = "" # Initialize user input
category = 1 # Initialize category

puts ""
puts "OSU Technical Job Listings"
puts "----------------------------------------------------"

loop do
	break if input == 'q'
	puts ""
	puts "Position Categories: "
	puts "  1. Developer Positions"
	puts "  2. Information Technology Positions"
	puts "  3. CSS Positions"
	puts ""

	loop do
		print "Enter category or 'q' to quit: "
		input = gets.chomp
		category = input.to_i
		break if category == 1 || category == 2 || category == 3 || input == 'q'
		puts "Invalid input. Enter a category between 1 and 3 or 'q' to quit."
		puts ""
		puts "Position Categories: "
		puts "  1. Developer Positions"
		puts "  2. Information Technology Positions"
		puts "  3. CSS Positions"
		puts ""
	end

	case category
	when 1
		puts "Getting data..."
		html = Nokogiri::HTML(open(developer)) # Fetch data
		puts "------------------------------------------------------------"
		puts ""
		printJobList(html) # Display data
	when 2
		puts "Getting data..."
		html = Nokogiri::HTML(open(informationTechnology)) # Fetch data
		puts "------------------------------------------------------------"
		puts ""		
		printJobList(html) # Display data
	when 3
		puts "Getting data..."
		html = Nokogiri::HTML(open(css)) # Fetch data
		puts "------------------------------------------------------------"
		puts ""		
		printJobList(html) # Display data
	end
end

puts ""
puts "Program terminated"