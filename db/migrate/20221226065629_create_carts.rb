class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :user_email, null: false
      t.string :product_id, null: false
      t.string :item_id, null: false
      t.integer :quantity, null:false


      t.timestamps
    end
  end
end
