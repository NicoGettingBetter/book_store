class BaseDecorator < Drape::Decorator
  delegate_all
  include ActionView::Helpers::NumberHelper

  def full_name
    "#{object.first_name} #{object.last_name}"
  end

  def decorated_price
    number_to_currency object.price
  end

end
