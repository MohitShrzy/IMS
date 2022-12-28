class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :cart_id, null:false
      t.string :user_email, null: false
      t.string :product_id, null: false
      t.string :item_id, null: false
      t.integer :quantity, null:false



      t.timestamps
    end
  end
end
