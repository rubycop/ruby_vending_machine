# frozen_string_literal: true

require_relative '../models/vending_machine'

module Services
  # VendingMachineService represents a service that makes a core vm logic:
  # - processes returning a product
  # - processes returning a change
  # - clears change coins slot
  class VendingMachineService
    attr_accessor :vending_machine, :change_coins

    def initialize(vending_machine:)
      @vending_machine = vending_machine
      @change_coins = []
    end

    def process_return_product(product)
      product.remove_product
    end

    def process_change(change)
      return if change.zero?

      sorted_coins_by_value.each do |coin|
        next if change < coin.value || coin.count.zero?

        coin.remove_coin
        @change_coins << coin.value

        return process_change(change - coin.value)
      end
    end

    def clear_change_coins
      @change_coins = []
    end

    private

    def sorted_coins_by_value
      @vending_machine.coins.sort { |a, b| b.value <=> a.value }
    end
  end
end
