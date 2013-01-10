module SuppliersHelper
  def supplier_name_with_rating(supplier)
    "#{supplier.name} [#{supplier.round_rating}]"
  end

  def supplier_status_class(supplier)
    return "success" if supplier.free?
    return "warning" if supplier.in_work?
  end
end
