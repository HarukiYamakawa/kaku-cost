# Productsのシードデータ
products = [
  { name: "蜜柑", price: 500, description: "果物です", stock: 10, image_url: "https://kaku-public-bucket-static-contents.s3.ap-northeast-1.amazonaws.com/mikan.png" },
  { name: "餅", price: 600, description: "穀物です", stock: 20, image_url: "https://kaku-public-bucket-static-contents.s3.ap-northeast-1.amazonaws.com/moti.png" },
  { name: "ナッツ", price: 700, description: "種実です", stock: 30, image_url: "https://kaku-public-bucket-static-contents.s3.ap-northeast-1.amazonaws.com/nuts.png" },
  { name: "栄螺", price: 800, description: "貝類です", stock: 40, image_url: "https://kaku-public-bucket-static-contents.s3.ap-northeast-1.amazonaws.com/sazae.png" },
]

# データベースに追加
products.each do |product|
  Product.create!(product)
end