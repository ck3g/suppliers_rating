class Supplier < ActiveRecord::Base
  attr_accessible :name, :rank

  validates :name, presence: true
  validates :rank, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5 }
end
