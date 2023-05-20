# frozen_string_literal: true

require_relative 'lib/services/cli_service'

cli = Services::CLIService.new

cli.print_welcome
cli.init_vending_machine

loop do
  case cli.select_vm_action
  when '1'
    cli.print_products
    cli.print_coins
    cli.print_vm_balance
  when '2'
    cli.select_product
    cli.enter_amount
    cli.return_product
    cli.return_change
    cli.print_change
  else
    Process.exit!
  end
end
