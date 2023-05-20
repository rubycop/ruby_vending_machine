# frozen_string_literal: true

module Models
  # Coin class represents a Coin entity
  class Coin
    attr_accessor :value, :count

    def initialize(value:, count:)
      @value = value
      @count = count
    end

    def add_coin
      @count += 1
    end

    def remove_coin
      raise 'No coins left' if @count.zero?

      @count -= 1
    end
  end
end
