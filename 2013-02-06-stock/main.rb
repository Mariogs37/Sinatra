require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

def get_quote(stock_name)
  YahooFinance::get_quotes(YahooFinance::StandardQuote, stock_name)[stock_name].lastTrade
end

get '/stock' do
  @name = params[:name]
  if @name.nil?
    @price = nil
  else
    @name = @name.upcase
    @price = get_quote(@name)
  end
  erb :stock
end