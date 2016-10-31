class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Book, Review, Category, Author, Rate]
    if user
      can :create, Rate
      can :update, Review, user_id: user.id
      can :manage, User, id: user.id
      can :manage, Order, user_id: user.id
      can :manage, OrderItem, order_id: user.current_order.id
      if user.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, [Order, Book, Review, Category, Author, Delivery, Coupon, User, OrderItem]
      end
    end
  end
end
