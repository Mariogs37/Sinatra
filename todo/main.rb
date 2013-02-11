require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'httparty'
require 'json'
require 'pg'

get '/new' do
  sql = 'SELECT  FROM tasks;'

  conn = PG.connect(:dbname =>'todo_app', :host => 'localhost')
  @rows = (conn.exec(sql))
  conn.close
  erb :new
end