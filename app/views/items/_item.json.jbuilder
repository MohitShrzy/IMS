json.extract! item, :id, :item_name, :description, :quantity, :price, :product_id, :created_at, :updated_at
json.url item_url(item, format: :json)
