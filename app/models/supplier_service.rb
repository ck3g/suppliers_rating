class SupplierService < ActiveRecord::Base
  attr_accessible :price, :service_id, :supplier_id

  belongs_to :supplier
  belongs_to :service

  validates :supplier_id, :service_id, presence: true
  validates :price, presence: true, numericality: true
end
