class Service < ActiveRecord::Base
  attr_accessible :name, :category_id

  has_many :supplier_services, dependent: :destroy
  has_many :tasks, through: :supplier_services
  belongs_to :category

  validates :name, presence: true, uniqueness: true

  scope :term, ->(term) { where{ name.like_any term.split.map { |word| "%#{word}%" } } }
  scope :category_id, ->(id) { where(:category_id => id) }
end
