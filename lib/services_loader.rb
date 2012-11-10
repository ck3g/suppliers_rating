class ServicesLoader
  def self.list
    Service.joins{supplier_services.outer}.
      group{services.id}.
      select{"services.*, COUNT(supplier_services.id) AS suppliers_count"}.
      order{services.name}
  end
end
