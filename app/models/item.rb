class Item < ApplicationRecord
  belongs_to :product
  has_many :orders
  
end
