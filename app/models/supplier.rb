class Supplier < ActiveRecord::Base
  attr_accessible :name, :rating, :contacts, :pay_to, :total_amount

  has_many :supplier_services, dependent: :destroy
  has_many :tasks, through: :supplier_services

  validates :name, presence: true
  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 10 }
  validates :total_amount, numericality: true

  scope :term, ->(term) { where{ name.like_any term.split.map { |word| "%#{word}%" } } }

  def recalculate_rating!
    ratings = tasks.closed.pluck(:rating)
    return if ratings.blank?
    rating = ratings.inject(&:+).to_f / ratings.count
    update_column :rating, rating
  end

  def round_rating
    rating.to_f.round(2)
  end

  def name_with_rating
    "#{name} [#{round_rating}]"
  end
end

