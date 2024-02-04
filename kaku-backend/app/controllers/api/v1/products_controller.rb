require 'rest-client'
class Api::V1::ProductsController < ApplicationController

  include Paginatable

  def index
    if params[:page].present?
      products = Product.all.page(params[:page]).per(3)
      render json: products, meta: page_params(products), adapter: :json, status: :ok
    elsif params[:cache].present?
      redis_key = 'products_list'
      begin
        cached_products = $redis.get(redis_key)

        if cached_products.nil?
          products = Product.all
          serialized_products = ActiveModelSerializers::SerializableResource.new(products).to_json
          $redis.set(redis_key, serialized_products)
          $redis.expire(redis_key, 10.seconds.to_i)
        else
          products = JSON.parse(cached_products)
        end
        render json: { cache: "ok"}, status: :ok
      rescue StandardError
        products = Product.all
        render json: products, status: :ok
      end
    else
      products = Product.all
      render json: products, status: :ok
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    # response.headers['Cache-Control'] = 'public, max-age=60, s-maxage=60, stale-while-revalidate=60'
    render json: product
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    product = Product.find_by(id: params[:id])
    if product.update(product_params)
      render json: product, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    if product.destroy
      render json: product, status: :ok
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :stock, :image_url)
  end
end
