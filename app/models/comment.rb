class Comment < ActiveRecord::Base
  attr_accessible :message

  belongs_to :commentable, polymorphic: true

  validates :message, presence: true
end
