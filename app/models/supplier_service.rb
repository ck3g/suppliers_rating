class SupplierService < ActiveRecord::Base
  attr_accessible :price, :service_id, :supplier_id

  belongs_to :supplier
  belongs_to :service
  has_many :tasks

  validates :supplier_id, :supplier_name, :service_id, :service_name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  delegate :name, to: :supplier, prefix: true, allow_nil: true
  delegate :name, to: :service, prefix: true, allow_nil: true
end
