module BloomRemit2
  class Rate
    class << self
      # Returns a real-time hash of currency exchange rates that update every minute
      #
      # Supported currencies include: AED, AUD, BCH, BTC, CAD, CNY, DASH, ETH, EUR, GBP, HKD,
      # IDR, INR, JPY, KRW, LINK, LTC, MYR, NPR, PHP, SGD, THB, USD, USDT, VND, XLM, XRP, ZAR.
      # By default, all rates provided are relative to USD.
      #
      # @return currency_exchange_rates [Hash] where key is 6-letter currency pair and value is price
      def list
        rates = Client.get(path)
        JSON.parse(rates.body)
      end

      # Retrieves one currency exchange rate
      # @param currency_pair [String] 6-letter currency pair (e.g. 'USDBTC')
      # @return rate [BloomRemit2::Rate]
      def retrieve(currency_pair)
        price = Client.get("#{path}&currency=#{currency_pair}").body
        { currency_pair => price.to_f }
      end

      private

      def path
        "api/v1/rates?partner_id=#{BloomRemit2.configuration.api_token}"
      end
    end
  end
end
