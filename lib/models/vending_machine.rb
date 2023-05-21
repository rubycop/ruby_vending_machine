# frozen_string_literal: true

require_relative '../data/products'

module Models
  # VendingMachine represents a model that works with
  # products and coins in vm
  class VendingMachine
    attr_accessor :coins, :products

    def initialize(products: [], coins: [])
      @products = products
      @coins = coins
    end

    def total_balance
      @coins.inject(0) { |sum, coin| sum + coin.value.to_f * coin.count }
    end

    def find_product_by_id(id)
      product = @products.detect { |item| item.id == id.to_i }
      raise "No product found with id: #{id}" unless product

      product
    end

    def find_coin_by_value(value)
      coin = @coins.detect { |item| item.value == value }
      raise "No coin found with value: #{value}" unless coin

      coin
    end

    # VM_2.0
    # In future extended VM we can add new product and coin from CLI directly
    #
    # def add_new_product(product)
    #   @products << product
    # end

    # def add_new_coin(coin)
    #   @coins << coin
    # end
  end
end
