class Supplier < ActiveRecord::Base
  attr_accessible :name, :rating

  validates :name, presence: true
  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5 }
end
