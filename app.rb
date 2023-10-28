require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  response = HTTP.get(api_url)
  api_data = JSON.parse(response.body)
  @currencies = api_data["currencies"] # this is a hash of currencies

  erb(:homepage)
end

get("/:from_currency") do
  @original_currency = params[:from_currency]

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  response = HTTP.get(api_url)
  api_data = JSON.parse(response.body)
  @currencies = api_data["currencies"]

  erb(:from_currency_result)
end

get("/:from_currency/:to_currency") do
  @original_currency = params[:from_currency]
  @destination_currency = params[:to_currency]

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  response = HTTP.get(api_url)
  api_data = JSON.parse(response.body)
  @result = api_data["result"]

  erb(:to_currency_result)
end
