# frozen_string_literal: true

require_relative '../data/coins'
require_relative '../data/products'
require_relative '../models/vending_machine'
require_relative './data_service'
require_relative './vending_machine_service'
require_relative './io_service'

module Services
  # CLIService represents runtime methods to interact with vm
  class CLIService
    attr_accessor :vending_machine_service, :selected_product, :inserted_amount

    def initialize
      vm = Models::VendingMachine.new(
        products: DataService.bootstraped_sample_products,
        coins: DataService.bootstraped_sample_coins
      )
      @vending_machine_service = VendingMachineService.new(vending_machine: vm)
    end

    def select_product
      input = IOService.readline('Select a product (id): ')
      begin
        @selected_product = @vending_machine_service.vending_machine
                                                    .find_product_by_id(input)
      rescue RuntimeError => e
        IOService.print_error(e.message)
        Process.exit! && return
      end

      validate_selected_product
    end

    def enter_amount
      input = IOService.readline('Enter amount to insert: ')
      @inserted_amount = input.to_f

      return unless inserted_amount < @selected_product.price

      IOService.print_error('You inserted less than product costs')
      IOService.print_message("You get \"#{inserted_amount}\" money back")
      Process.exit!
    end

    def return_change
      change = @inserted_amount - @selected_product.price

      if @vending_machine_service.vending_machine.total_balance < change
        IOService.print_error('There are no enough coins for change')
        IOService.print_message("You get \"#{inserted_amount}\" money back")
        Process.exit!

        return
      end

      @vending_machine_service.clear_change_coins
      @vending_machine_service.process_change(change)
    end

    def return_product
      @vending_machine_service.process_return_product(@selected_product)
    end

    # Printing info

    def print_welcome
      welcome_text = "########################################\n"\
                     "#                                      #\n"\
                     "#   Welcome to Ruby Vending Machine!   #\n"\
                     "#                                      #\n"\
                     '########################################'

      IOService.print_message(welcome_text.colorize(:blue))
    end

    def select_vm_action
      text = "Select action:\n"\
             "1. Check vm info\n"\
             "2. Buy product\n"\
             "Exit by default\n"
      IOService.print_message(text)
      IOService.readline
    end

    def print_change
      change_coins = @vending_machine_service.change_coins
      IOService.print_message('Change info'.colorize(:cyan))
      IOService.print_table(
        headings: ['Change amount', 'Coins value'],
        rows: [[change_coins.sum, change_coins.join(', ')]]
      )
    end

    def print_vm_balance
      IOService.print_message('VM balance'.colorize(:cyan))
      IOService.print_table(
        rows: [
          ['machine balance', @vending_machine_service.vending_machine.total_balance]
        ]
      )
    end

    def print_products
      IOService.print_message('List of available products'.colorize(:cyan))
      IOService.print_table(
        headings: %w[id name price count],
        rows: @vending_machine_service.vending_machine.products.map do |product|
          [product.id, product.name, product.price, product.count]
        end
      )
    end

    def print_coins
      IOService.print_message('List of available coins for change'.colorize(:cyan))
      IOService.print_table(
        headings: %w[value count],
        rows: @vending_machine_service.vending_machine.coins.map do |coin|
          [coin.value, coin.count]
        end
      )
    end

    private

    def validate_selected_product
      if @selected_product.count < 1
        IOService.print_message("There is no '#{@selected_product.name}' in vm right now.".colorize(:orange))
        Process.exit! && return
      end

      IOService.print_message("Selected: #{@selected_product.name.colorize(:green)}")
    end
  end
end
