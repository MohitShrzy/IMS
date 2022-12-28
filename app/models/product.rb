class Product < ApplicationRecord
    has_many :orders
    has_many :items
end
