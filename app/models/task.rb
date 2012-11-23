class Task < ActiveRecord::Base
  STATUSES = %w[open closed]

  attr_accessible :cost, :description, :finished_at, :rating, :status,
    :supplier_service_id, :title, :supplier_id, :service_id, :supplier_name,
    :service_name

  attr_accessor :supplier_id, :service_id, :supplier_name, :service_name

  belongs_to :supplier_service
  has_one :supplier, through: :supplier_service
  has_one :service, through: :supplier_service
  has_many :comments, as: :commentable, dependent: :destroy

  validates :supplier_service_id, :title, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :rating, allow_blank: true, inclusion: { in: 1..5 }

  delegate :supplier_name_with_rating, to: :supplier_service, prefix: false

  scope :opened, -> { where{ status == "open" } }
  scope :closed, -> { where{ status == "closed" } }

  def closed?
    status == "closed"
  end

  def open?
    status == "open"
  end

  def close_with_rating!(rating)
    update_attributes status: "closed", rating: rating, finished_at: Time.current
    self.supplier.recalculate_rating!
  end

  def reopen!
    update_column :status, "open"
    update_column :finished_at, nil
    update_column :rating, nil
    self.supplier.recalculate_rating!
  end

  def self.init_from_supplier_and_service(supplier, service, params = {})
    Task.new params.merge({
      supplier_id: supplier.try(:id),
      supplier_name: supplier.try(:name),
      service_id: service.try(:id),
      service_name: service.try(:name)
    })
  end
end
