# frozen_string_literal: true

require_relative '../../lib/services/vending_machine_service'
require_relative '../../lib/services/data_service'
require_relative '../../lib/models/vending_machine'

module Services
  describe VendingMachineService, type: :model do
    let(:vm) do
      Models::VendingMachine.new(
        products: DataService.bootstraped_sample_products,
        coins: DataService.bootstraped_sample_coins
      )
    end
    let(:product) { vm.products.first }

    subject { described_class.new(vending_machine: vm) }

    it 'clears change coins' do
      expect(subject.clear_change_coins).to be_empty
    end

    it 'splits change on coins correctly' do
      subject.process_change(12.5)

      expect(subject.instance_variable_get('@change_coins'))
        .to eq [5, 5, 2, 0.5]
    end

    it 'returns product correctly' do
      expect do
        subject.process_return_product(product)
      end.to change(product, :count).by(-1)
    end
  end
end
