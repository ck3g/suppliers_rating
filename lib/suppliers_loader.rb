class SuppliersLoader
  def self.list
    Supplier.joins{supplier_services.outer}.
      group{suppliers.id}.
      select{"suppliers.*, COUNT(supplier_services.id) AS services_count"}.
      order("rating DESC, COUNT(supplier_services.id) DESC")
  end
end
