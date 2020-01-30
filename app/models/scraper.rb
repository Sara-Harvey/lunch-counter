require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

	def self.scrape 
		self.make_restaurants
		self.make_sandwiches	
	end

	def self.make_restaurants
		list = ["Cosi", "Lenwich", "Panera", "Potbelly", "Pret a Manger"]
		list.each do |restaurant_name|
		Restaurant.find_or_create_by(name: "#{restaurant_name}")
		end
	end

	def self.make_sandwiches 
		self.cosi_scrape
		self.lenwich_scrape
		self.panera_scrape 
		self.potbelly_scrape
		self.pret_scrape
	end

	def self.get_page(url)
	    page = Nokogiri::HTML(open(url))
	    page
	end

	def self.cosi_scrape
		page = self.get_page('public/cosi.html')
		sandwiches = []

		page.css(".product-details").each do |sandwich|
		sandwiches << {
			title: sandwich.css(".product-title").text.strip,
			calories: sandwich.css(".product-calories").text.strip,
			description: sandwich.css(".product-description").text.strip,
			restaurant_id: 1 }
		end
			sandwiches.each do |hash|
			Sandwich.find_or_create_by(hash)
		end
	end

	def self.lenwich_scrape 
		page = self.get_page('public/lenwich.html')
		sandwiches = []

		page.css(".item").each do |sandwich|
		sandwiches << {
			title: sandwich.css(".name").text.strip,
			calories: sandwich.css(".cal").text.strip,
			description: sandwich.css(".description").text.strip,
			restaurant_id: 2 }
		end
			sandwiches.each do |hash|
			Sandwich.find_or_create_by(hash)
		end
	end

	def self.panera_scrape 
		page = self.get_page('public/panera.html')
		sandwiches = []

		page.css("article.one-column").each do |sandwich|
		sandwiches << {
			title: sandwich.css(".item-name").text.strip,
			calories: sandwich.css(".calorie-count span.calories").text.strip,
			description: sandwich.css(".item-content p").text.strip,
			restaurant_id: 3 }
		end
			sandwiches.each do |hash|
			Sandwich.find_or_create_by(hash)
		end
	end

	def self.potbelly_scrape 
		page = self.get_page('public/potbelly.html')
		sandwiches = []

		page.css("div.menu-item--globalfalse").each do |sandwich|
		sandwiches << {
			title: sandwich.css("h2").text.strip,
			calories: sandwich.css(".cals").text.strip,
			description: sandwich.css(".description").text.strip,
			restaurant_id: 4 }
		end
			sandwiches.each do |hash|
			Sandwich.find_or_create_by(hash)
		end
	end

	def self.pret_scrape 
		page = self.get_page('public/pret.html')
		sandwiches = []

		page.css("article.col-sm-4").each do |sandwich|
		sandwiches << {
			title: sandwich.css(".textwrap h3").text.strip,
			calories: sandwich.css(".textwrap h2").text.strip,
			description: sandwich.css(".textwrap p").text.strip,
			restaurant_id: 5 }
		end
			sandwiches.each do |hash|
			Sandwich.find_or_create_by(hash)
		end
	end

end


