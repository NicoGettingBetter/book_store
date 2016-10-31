class OrdersController < ApplicationController
  include Rectify::ControllerHelpers
  before_action :set_order, only: [:destroy, :complete]
  before_action :set_presenter, except: :index
  load_and_authorize_resource
  helper AddressHelper

  def index
    present OrdersPresenter.new(current_user)
  end

  def show
  end

  def edit
  end

  def update
    @form = OrderForm.from_params(order_params, order_items: order_items_params)
    validate = [:order_items]
    validate << :coupon if order_params[:coupon] != ''

    UpdateOrder.call(@form, validate) do
      on(:ok) { redirect_to edit_order_path(id: current_order.id) }
      on(:invalid) { render 'edit' }
    end
  end

  def edit_address
  end

  def order_address
    @form = OrderForm.new()
    @form.from_addresses(addresses_params)
    add_address_to_presenter if @form.invalid?
    UpdateOrder.call(@form, :addresses) do
      on(:ok) { redirect_to edit_delivery_order_path }
      on(:invalid) { render 'edit_address' }
    end
  end

  def edit_delivery
    presenter.deliveries = Delivery.all
  end

  def order_delivery
    @form = OrderForm.new(delivery: DeliveryForm.new(id: delivery_params.to_i))
    presenter.deliveries = Delivery.all if @form.invalid?

    UpdateOrder.call(@form, :delivery) do
      on(:ok) { redirect_to edit_payment_order_path }
      on(:invalid) { render 'edit_delivery' }
    end
  end

  def edit_payment
    presenter.credit_card = CreditCardForm.from_model(presenter.order.credit_card)
  end

  def order_payment
    @form = OrderForm.new(credit_card: CreditCardForm.new(credit_card_params))
    add_credit_card_to_presenter if @form.invalid?

    UpdateOrder.call(@form, :credit_card) do
      on(:ok) { redirect_to edit_confirm_order_path }
      on(:invalid) { render 'edit_payment' }
    end
  end

  def edit_confirm
  end

  def order_confirm
    @form = OrderForm.new()
    UpdateOrder.call(@form, :order) do
      on(:ok) { redirect_to complete_order_path }
    end
  end

  def complete
  end

  def destroy
    OrderItem.delete @order.order_items
    @order.delete
    respond_to do |format|
      format.html { redirect_to edit_order_path(current_order.id) }
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:coupon, :billing_address, :shipping_address, :credit_card)
    end

    def order_items_params
      params[:order][:order_items]
    end

    def set_presenter
      present OrderPresenter.new(order: Order.find(params[:id]))
    end

    def address_params type
      params.require(type).permit(:id, :first_name, :last_name, :street, :zipcode, :city, :phone, :country_id)
    end

    def check_params
      params.require(:use_billing_address).permit(:check)[:check] == '1'
    end

    def addresses_params
      {
        billing_address: address_params(:billing_address),
        shipping_address: address_params(:shipping_address),
        check: check_params
      }
    end

    def add_address_to_presenter
      presenter.billing_address = @form.billing_address
      if @form.same_address
        presenter.same_address = true
      else
        presenter.shipping_address = @form.shipping_address
      end
    end

    def delivery_params
      return 0 unless params[:order]
      params.require(:order).permit(:shipping)[:shipping]
    end

    def add_credit_card_to_presenter
      presenter.credit_card = @form.credit_card
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :expiration_month, :expiration_year, :cvv)
    end
end
