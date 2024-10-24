require "net/http"
require "json"

module LatestStockPrice
  class Client
    BASE_URL = "https://latest-stock-price.p.rapidapi.com"

    def initialize(api_key)
      @api_key = api_key
    end

    def price(isin)
      request("/equities?ISIN=#{isin}")
    end

    def prices(indicies, isins)
      isins_param = nil
      indicies_param = nil
      url_prices = "/equities?"
      if isins and not indicies
        isins_param = isins.join(",")
        url_prices.concat("ISIN=#{isins_param}")
      elsif not isins and indicies
        indicies_param = indicies.join(",")
        url_prices.concat("Indicies=#{indicies_param}")
      elsif isins and indicies
        isins_param = isins.join(",")
      indicies_param = indicies.join(",")
        url_prices.concat("ISIN=#{isins_param}&Indicies=#{indicies_param}")
      end
      request(url_prices)
    end

    def price_all
      request("/equities")
    end

    private

    def request(endpoint)
      url = URI("#{BASE_URL}#{endpoint}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = @api_key
      request["X-RapidAPI-Host"] = "latest-stock-price.p.rapidapi.com"

      response = http.request(request)
      parse_response(response)
    end

    def parse_response(response)
      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise LatestStockPrice::Error, "Error fetching data: #{response.message}"
      end
    end
  end
end
