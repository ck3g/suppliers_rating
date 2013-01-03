class Comment < ActiveRecord::Base
  STATUSES = %w(paid)
  attr_accessible :message, :status

  belongs_to :commentable, polymorphic: true

  validates :message, presence: true
  validates :status, inclusion: { in: STATUSES }, allow_blank: true
end
