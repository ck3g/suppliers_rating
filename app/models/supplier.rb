class Supplier < ActiveRecord::Base
  attr_accessible :name, :rating

  has_many :supplier_services, dependent: :destroy
  has_many :tasks, through: :supplier_services

  validates :name, presence: true
  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5 }

  scope :term, ->(term) { where{ name.like_any term.split.map { |word| "%#{word}%" } } }
end

