module ApplicationHelper
  def number_to_currency(number, options = {})
    super number, options.merge({locale: :en})
  end
end
