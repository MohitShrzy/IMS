class Order < ApplicationRecord
    belongs_to :item
    belongs_to :product
end
