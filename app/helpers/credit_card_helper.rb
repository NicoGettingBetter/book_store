module CreditCardHelper
  def months
    Date::MONTHNAMES.drop(1)
  end
end