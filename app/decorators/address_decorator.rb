class AddressDecorator < BaseDecorator
  delegate_all

  def country
    object.country.name
  end
end
