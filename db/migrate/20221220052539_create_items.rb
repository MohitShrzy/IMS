class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :description
      t.integer :quantity
      t.integer :price
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
