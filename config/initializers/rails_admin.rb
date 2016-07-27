RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.included_models = [
    'Book', 
    'Order', 
    'Author', 
    'Review', 
    'Category', 
    'Delivery', 
    'Coupon']

  ## == Cancan ==
  config.authorize_with :cancan

  config.model 'Order' do
    list do
      field :state
      field :total_price
      field :delivery
      field :coupon
    end
    edit do
      include_fields :state
      field :state, :enum do
        enum do
          init_state = bindings[:object].state
          bindings[:object].aasm.states(permitted: true).map(&:name).unshift(init_state)
        end
      end
    end
  end

  config.model 'Review' do
    edit do
      field :approved
    end
  end


  config.actions do
    dashboard                     
    index                        
    new do
      only ['Book', 'Author', 'Category', 'Delivery', 'Coupon']
    end
    bulk_delete do
      only ['Book', 'Author', 'Category']
    end
    show
    edit
    delete do
      only ['Book', 'Author', 'Category']
    end
  end
end
