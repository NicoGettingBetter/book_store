class SettingsController < ApplicationController
  include Rectify::ControllerHelpers

  def index
    return redirect_to root_path if cannot? :manage, User
    present SettingsPresenter.new(default_billing_address: get_address_form(:default_billing_address),
                                  default_shipping_address: get_address_form(:default_shipping_address))
  end

  private

    def get_address type
      current_user.send(type) || Address.new
    end

    def get_address_form type
      AddressForm.from_model(get_address type)
    end
end
