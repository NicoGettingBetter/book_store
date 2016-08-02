class AddressesController < ApplicationController
  include Rectify::ControllerHelpers

  def create
    @form = AddressForm.from_params(address_params)

    set_presenter if @form.invalid?
    CreateAddress.call(@form) do
      on(:ok) { redirect_to settings_path }
      on(:invalid) { render 'settings/index' }
    end
  end

  def update
    @form = AddressForm.from_params(address_params, id: params[:id])

    set_presenter if @form.invalid?
    UpdateAddress.call(@form) do
      on(:ok) { redirect_to settings_path }
      on(:invalid) { render 'settings/index' }
    end
  end

  private
    def address_params
      params.require(:address).permit(:first_name, :last_name, :street, :zipcode, :city, :phone, :country_id, :type)
    end

    def get_address_form type
      AddressForm.from_model(get_address type)
    end

    def get_address type
      current_user.send(type) || Address.new
    end

    def set_presenter
      present SettingsPresenter.new(
        default_billing_address: get_address_form(:default_billing_address),
        default_shipping_address: get_address_form(:default_shipping_address))
      presenter.send("#{@form.type}=", @form) if @form
    end
end
