class Task < ActiveRecord::Base
  STATUSES = %w[open closed]

  attr_accessible :cost, :description, :finished_at, :rating, :status, :supplier_service_id, :title

  belongs_to :supplier_service
  has_one :supplier, through: :supplier_service
  has_one :service, through: :supplier_service

  validates :supplier_service_id, :title, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :rating, allow_blank: true, inclusion: { in: 1..5 }

  delegate :supplier_name, to: :supplier_service, prefix: false
  delegate :service_name, to: :supplier_service, prefix: false

end
