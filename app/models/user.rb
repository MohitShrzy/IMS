class User < ApplicationRecord
    validates :name, presence: true
    validates :password, presence: true
    validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
    
end
