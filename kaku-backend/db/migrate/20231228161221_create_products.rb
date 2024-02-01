class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :stock, null: false, default: 0
      t.string :description
      t.string :image_url
      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
