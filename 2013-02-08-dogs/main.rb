require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

get 'dogs' do
  sql = "select * from dogs"
  @rows = run_sql(sql)
  erb :dogs
end

post '/create' do
  @name = params[:name]
  @photo = params[:photo]
  @breed = params[:breed]
  sql = "insert into dogs (name, photo, breed) values ('#{name}', '#{photo}', '#{breed}')"
  run_sql(sql)
  redirect to('/dogs')
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'dog_db', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end