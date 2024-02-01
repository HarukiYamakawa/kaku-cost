require 'rails_helper'

RSpec.describe Product do
  let!(:product) { build(:product) }

  describe 'バリデーション' do
    context '有効な属性値の場合' do
      it '正常に登録できること' do
        expect(product).to be_valid
      end
    end

    context 'nameが空白の場合' do
      it '無効であること' do
        product.name = nil
        expect(product).not_to be_valid
      end
    end

    context 'nameが重複している場合' do
      it '無効であること' do
        product.save
        product_duplication = build(:product, name: product.name)
        expect(product_duplication).not_to be_valid
      end
    end

    context 'nameが15文字以上の場合' do
      it '無効であること' do
        product.name = '1' * 16
        expect(product).not_to be_valid
      end
    end

    context 'priceが空白の場合' do
      it '無効であること' do
        product.price = nil
        expect(product).not_to be_valid
      end
    end

    context 'priceが整数以外の場合' do
      it '無効であること' do
        product.price = 1.1
        expect(product).not_to be_valid
      end
    end

    context 'priceが負の数の場合' do
      it '無効であること' do
        product.price = -1
        expect(product).not_to be_valid
      end
    end

    context 'stockが空白の場合' do
      it '無効であること' do
        product.stock = nil
        expect(product).not_to be_valid
      end
    end

    context 'stockが整数以外の場合' do
      it '無効であること' do
        product.stock = 1.1
        expect(product).not_to be_valid
      end
    end

    context 'stockが負の数の場合' do
      it '無効であること' do
        product.stock = -1
        expect(product).not_to be_valid
      end
    end

    context 'descriptionが1000文字以上の場合' do
      it '無効であること' do
        product.description = '1' * 1001
        expect(product).not_to be_valid
      end
    end

  end
end
