require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'erubis'
require 'open-uri'
require 'json'
require 'uri'
# class Movie
# 	def initialize(imdb)
# 		file = open("http://www.omdbapi.com/?s=#{URI.escape(imdb)}&r=json")
# 		@results = JSON.load(file.read)
# 		@title = @results['Title']
# 		@plot = @results['Plot']
# 		@imdbid = imdb
# 	end
# end


#---------------Erik's approach-----
# before do
# 	@page = default
# 	@app_name = "Movies App"
# 	@page_title = app_name
# end


get '/' do
	erb :home
end

get '/search' do
	@page = :serp
	@title = params[:title].capitalize
	@page_title +=
	file = open("http://www.omdbapi.com/?s=#{URI.escape(@title)}&r=json")
	@results = JSON.load(file.read)
	erb :search
end

# get '/search/lucky' do
# 	@title = params[:q]
# 	file = open ("http://www.omdbapi.com/?t=#{URI.escape(@title)}&r=json")
# 	@results = JSON.load(file.read)
# 	erb :serach_lucky	
# end


get '/search/:id' do
	@id = params[:id]
	movie = Movie.new(@id)
	@title = movie.title
	@plot = movie.plot

	file = open("http://www.omdbapi.com/?i=#{URI.escape(@id)}&r=json")
	@movie_details = JSON.load(file.read)
	erb :movie
end
