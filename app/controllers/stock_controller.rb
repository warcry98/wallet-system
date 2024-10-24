class StockController < ApplicationController
  def price
    client = LatestStockPrice::Client.new(ENV["RAPIDAPI_STOCK_API_KEY"])
    @price = client.price(params[:isin])
    render json: @price
  end

  def prices
    client = LatestStockPrice::Client.new(ENV["RAPIDAPI_STOCK_API_KEY"])
    @prices = client.prices(params[:indicies], params[:isin])
    render json: @prices
  end

  def all_prices
    client = LatestStockPrice::Client.new(ENV["RAPIDAPI_STOCK_API_KEY"])
    @all_prices = client.price_all
    render json: @all_prices
  end
end
