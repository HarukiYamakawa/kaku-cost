class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :description, :stock, :image_url
end
