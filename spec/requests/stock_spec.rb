require 'rails_helper'
require 'latest_stock_price/client'

RSpec.describe "Stocks", type: :request do
  describe "GET /stock/all_prices" do
    it 'fetches prices for all stocks' do
      get '/stock/all_prices', headers: { Authorization: 'Bearer some_token' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('INE117A01022')
    end
  end

  describe "GET /stock/prices" do
    it 'fetches prices for all stocks with ISIN' do
      get '/stock/prices', params: { isin: [ 'INE117A01022', 'INE931S01010' ] }, headers: { Authorization: 'Bearer some_token' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('INE117A01022')
    end

    it 'fetches prices for all stocks with Indicies' do
      get '/stock/prices', params: { indicies: [ 'BANKNIFTY', 'CNX100' ] }, headers: { Authorization: 'Bearer some_token' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('INE117A01022')
    end

    it 'fetches prices for all stocks with ISIN and Indicies' do
      get '/stock/prices', params: { isin: [ 'INE117A01022', 'INE931S01010' ], indicies: [ 'BANKNIFTY', 'CNX100' ] }, headers: { Authorization: 'Bearer some_token' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('INE117A01022')
    end
  end

  describe "GET /stock/price" do
    it 'fetches price for single stocks' do
      get '/stock/price', params: { isin: 'INE117A01022' }, headers: { Authorization: 'Bearer some_token' }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('INE117A01022')
    end
  end
end
