# frozen_string_literal: true

require_relative '../models/product'
require_relative '../models/coin'

module Services
  # DataService processing sample data into model entities
  class DataService
    def self.bootstraped_sample_products
      DEFAULT_PRODUCT_SET.map do |product|
        Models::Product.new(
          id: product[:id],
          name: product[:name],
          price: product[:price],
          count: product[:count]
        )
      end
    end

    def self.bootstraped_sample_coins
      DEFAULT_COIN_SET.map do |coin|
        Models::Coin.new(
          value: coin[:value],
          count: coin[:count]
        )
      end
    end
  end
end
