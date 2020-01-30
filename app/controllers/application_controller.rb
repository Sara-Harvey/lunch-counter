require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  get "/start" do
    Scraper.scrape
    erb :start
  end

  get "/all" do
    @full_list = Sandwich.all
    erb :index
  end

  get "/:name" do
    @name = params[:name]
    @restaurant = Restaurant.find_by(name: params[:name].to_s.gsub( /_/ , ' '))
    @sort = @restaurant.sandwiches.sort_by {|item| item.calories}
    erb :sandwiches
  end

end
