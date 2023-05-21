# frozen_string_literal: true

require_relative '../../lib/services/data_service'
require_relative '../../lib//data/products'
require_relative '../../lib//data/coins'

module Services
  describe DataService, type: :model do
    let(:product_hash) { DEFAULT_PRODUCT_SET.first }
    let(:coin_hash) { DEFAULT_COIN_SET.first }

    subject { described_class }

    it 'processes products hash data into array of Product model' do
      products = subject.bootstraped_sample_products

      expect(products.first.id).to eq(product_hash[:id])
      expect(products.first.name).to eq(product_hash[:name])
      expect(products.first.price).to eq(product_hash[:price])
      expect(products.first.count).to eq(product_hash[:count])
    end

    it 'processes coins hash data into array of Coin model' do
      coins = subject.bootstraped_sample_coins

      expect(coins.first.value).to eq(coin_hash[:value])
      expect(coins.first.count).to eq(coin_hash[:count])
    end
  end
end
