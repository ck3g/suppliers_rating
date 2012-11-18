class Task < ActiveRecord::Base
  STATUSES = %w[open closed]

  attr_accessible :cost, :description, :finished_at, :rating, :status, :supplier_service_id, :title

  belongs_to :supplier_service
  has_one :supplier, through: :supplier_service
  has_one :service, through: :supplier_service
  has_many :comments, as: :commentable, dependent: :destroy

  validates :supplier_service_id, :title, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :rating, allow_blank: true, inclusion: { in: 1..5 }

  delegate :supplier_name, to: :supplier_service, prefix: false
  delegate :service_name, to: :supplier_service, prefix: false

  def closed?
    status == "closed"
  end

  def open?
    status == "open"
  end

  def close_with_rating!(rating)
    update_attributes status: "closed", rating: rating
    reload
    self.supplier.recalculate_rating!
  end

  def reopen!
    update_column :status, "open"
    reload
  end
end
