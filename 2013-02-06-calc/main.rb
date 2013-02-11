require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?


get '/calc' do
  @first = params[:first].to_f
  @second = params[:second].to_f

  @result = case params[:operator]

  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then @first * @second
  when '/' then @first / @second
  end

  erb :calc
end

# get '/calc/multiply/:x/:y' do
#   @result = params[:x].to_f * params[:y].to_f
#   erb :calc
# end

# get '/calc/add/:x/:y' do
#   @result = params[:x].to_f + params[:y].to_f
#   erb :calc
# end


# -----------------------------------------------#

get '/name/:first/:last' do
  "your name is : #{params[:first]} #{params[:last]}"
end

get '/hello' do
  'i am a master hacker ninja!!!'
end

get '/' do
  'this is the home page'
end

get '/ben' do
  'how\'s it going ben?'
end