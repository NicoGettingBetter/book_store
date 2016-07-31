class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Book, Review, Category, Author]
    if user
      can :read, [Order, User], user_id: user.id
      can :update, Review, user_id: user.id
      can :manage, [Order, OrderItem, User], user_id: user.id
      if user.admin?
        can :access, :rails_admin
        can :dashboard
        can :manage, [Order, Book, Review, Category, Author, Delivery, Coupon]
      end
    end
  end
end
