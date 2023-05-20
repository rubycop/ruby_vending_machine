# frozen_string_literal: true

module Models
  # Product class represents a Product entity
  class Product
    attr_accessor :id, :name, :price, :count

    def initialize(id:, name:, price:, count: 0)
      @id = id
      @name = name
      @price = price
      @count = count
    end

    def add_product
      @count += 1
    end

    def remove_product
      raise 'No products left' if @count.zero?

      @count -= 1
    end
  end
end
