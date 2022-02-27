class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
    validates :reason, presence: true
end
