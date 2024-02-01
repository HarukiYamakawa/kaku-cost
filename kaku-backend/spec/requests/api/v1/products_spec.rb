require 'rails_helper'

RSpec.describe 'Api::V1::Products' do
  describe 'GET api/v1/products' do
    context 'データが存在するとき' do
      let!(:products) { create_list(:product, 3) }

      it '商品の一覧が取得できること' do
        get '/api/v1/products'

        expect(response).to have_http_status(:success)

        json = response.parsed_body
        expect(json.length).to eq(3)

        expect(json.first.keys).to contain_exactly('id', 'name', 'price', 'description', 'stock', 'image_url')
      end
    end
  end

  describe 'GET api/v1/products/:id' do
    context 'データが存在するとき' do
      let!(:product) { create(:product) }

      it '商品の詳細が取得できること' do
        get "/api/v1/products/#{product.id}"

        expect(response).to have_http_status(:success)

        json = response.parsed_body
        expect(json.keys).to contain_exactly('id', 'name', 'price', 'description', 'stock', 'image_url')
      end
    end
  end

  describe 'POST api/v1/products' do
    context 'パラメータが正常なとき' do
      let!(:product_params) { attributes_for(:product, name: 'create_test') }

      it '商品の登録ができること' do
        post '/api/v1/products', params: { product: product_params}
        expect(response).to have_http_status(:created)
        expect(Product.last.name).to eq 'create_test'
      end
    end

    context 'パラメータが異常なとき' do
      let!(:product_params) { attributes_for(:product, name: nil) }

      it '商品の登録ができないこと' do
        post '/api/v1/products', params: { product: product_params}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Product.last).to be_nil
      end
    end
  end

  describe 'PUT api/v1/products/:id' do
    let!(:product) { create(:product) }

    context 'パラメータが正常なとき' do
      let!(:product_params) { attributes_for(:product, name: 'update_test') }

      it '商品の更新ができること' do
        put "/api/v1/products/#{product.id}", params: { product: product_params}
        expect(response).to have_http_status(:success)
        expect(product.reload.name).to eq 'update_test'
      end
    end

    context 'パラメータが異常なとき' do
      let!(:product_params) { attributes_for(:product, name: nil) }

      it '商品の更新ができないこと' do
        put "/api/v1/products/#{product.id}", params: { product: product_params}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(product.reload.name).not_to be_nil
      end
    end

  end

  describe 'DELETE api/v1/products/:id' do
    let!(:product) { create(:product) }

    context 'パラメータが正常なとき' do
      it '商品の削除ができること' do
        delete "/api/v1/products/#{product.id}"
        expect(response).to have_http_status(:success)
        expect(Product.last).to be_nil
      end
    end

  end


end
