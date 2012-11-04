class Service < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true
end
