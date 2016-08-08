class SettingsPresenter < Rectify::Presenter
  attribute :default_billing_address, AddressForm
  attribute :default_shipping_address, AddressForm


  [:first_name, :last_name].each do |name|
    define_method name do |type|
      send(type).send(name) || current_user.send(name) 
    end
  end

  [:street, :city, :zipcode, :phone].each do |name|
    define_method name do |type|
      send(type).send(name)
    end
  end

  def countries
    Country.all.collect{ |c| [c.name, c.id] }
  end

  def country type
    send(type).country_id
  end
end