module SuppliersHelper
  def supplier_name_with_rating(supplier)
    "#{supplier.name} [#{supplier.round_rating}]"
  end
end
