module ServicesHelper
  def categories
    categories = [[nil, t(:all)]]
    Category.order(:name).all.each do |category|
      categories << [category.id.to_s, category.name]
    end

    categories
  end
end
