class Service < ActiveRecord::Base
  attr_accessible :name

  has_many :supplier_services, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  scope :term, ->(term) { where{ name.like_any term.split.map { |word| "%#{word}%" } } }
end
