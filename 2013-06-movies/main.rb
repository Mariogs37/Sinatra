require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'httparty'
require 'json'
require 'pg'

get '/movies' do
  sql = 'SELECT poster FROM movies;'

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  @rows = (conn.exec(sql))
  conn.close
  erb :posters
end

get '/' do
  if params[:title].present?
    name = params[:title].gsub(' ', '+')
    url = "http://www.omdbapi.com/?t=#{name}"
    html = HTTParty.get(url)
    @hash = JSON(html)

    sql = "INSERT INTO movies (title, year, rated, released, runtime, genre, director, writers, actors, plot, poster) VALUES ('#{@hash['Title']}', '#{@hash['Year']}', '#{@hash['Rated']}', '#{@hash['Released']}', '#{@hash['Runtime']}', '#{@hash['Genre']}', '#{@hash['Director']}', '#{@hash['Writer']}', '#{@hash['Actors']}', '#{@hash['Plot']}', '#{@hash['Poster']}')"

    conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
    conn.exec(sql)
    conn.close
  end

  erb :movie
end