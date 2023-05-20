# frozen_string_literal: true

require 'readline'
require 'terminal-table'
require 'rainbow'

puts Rainbow('Welcome to ruby vending machine!').blue.bright

PRODUCTS = [
  { name: 'Coca Cola', price: 2.0, count: 10 },
  { name: 'Sprite', price: 2.5, count: 10 },
  { name: 'Fanta', price: 2.25, count: 10 },
  { name: 'Orange Juice', price: 3.0, count: 10 },
  { name: 'Water', price: 3.25, count: 0 }
].freeze

def print_products
  headings = ['Product Name', :price, :count]
  rows = [
    ['Coca Cola', 2.0, 10],
    ['Sprite', 2.5, 10],
    ['Fanta', 2.25, 10],
    ['Orange Juice', 3.0, 10],
    ['Water', 3.25, 0]
  ]
  puts Terminal::Table.new headings: headings, rows: rows
end

print_products

MACHINE_BALANCE = {
  5 => 5,
  3 => 5,
  2 => 5,
  1 => 5,
  0.5 => 5,
  0.25 => 5
}.freeze

def process_cashback(change, change_coins)
  return if change.zero?

  MACHINE_BALANCE.each_pair do |coin, _amount|
    next if change < coin || (MACHINE_BALANCE[coin]).zero?

    MACHINE_BALANCE[coin] -= 1
    change_coins << coin

    return process_cashback(change - coin, change_coins)
  end
end

def process_remove_product
  @selected_product[:count] -= 1
end

def machine_total_balance
  MACHINE_BALANCE.to_a.inject(0) { |sum, n| sum + n[0] * n[1] }
end

def product_available?
  @selected_product[:count].positive?
end

puts 'Select a product (number):'
PRODUCTS.each_with_index { |product, index| puts "#{index}. #{product[:name]}" }

index = Readline.readline('> ', false)
index = index.to_i

if index > PRODUCTS.size - 1
  puts 'There is no such product here'
  return
end

@selected_product = PRODUCTS[index.to_i]

puts @selected_product if @selected_product

if (@selected_product[:count]).zero?
  puts "There is no '#{@selected_product[:name]}'"
  return
end

puts 'Insert coins:'
inserted_amount = Readline.readline('> ', false)
inserted_amount = inserted_amount.to_f

puts 'inserted_Amount of coins should be > 0.0' && return if inserted_amount <= 0

if inserted_amount < @selected_product[:price].to_f
  puts 'You inserted less than product costs'
  puts "You get \"#{inserted_amount}\" coins back"
  return
end

change = inserted_amount - @selected_product[:price]

if machine_total_balance < change
  puts 'There are no enough coins for change'
  puts "You get \"#{inserted_amount}\" coins back"
  return
end

change_coins = []

if change.positive? && product_available?
  process_cashback(change, change_coins)
  process_remove_product
end

puts '-------------'
puts "your change: #{change_coins.sum} (#{change_coins.join(', ')})"
puts "machine balance: #{machine_total_balance}"
puts '-------------'
