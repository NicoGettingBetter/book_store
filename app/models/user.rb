class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  ratyrate_rater

  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :default_billing_address, class_name: 'Address'
  belongs_to :default_shipping_address, class_name: 'Address'

  validates_presence_of :first_name, :last_name

  scope :for_facebook, -> (auth) { where(provider: auth.provider, uid: auth.uid) }

  def current_order
    Order.in_progress(self).first ||
      Order.create( user: self, 
        billing_address: default_billing_address, 
        shipping_address: default_shipping_address)
  end

  def self.from_omniauth(auth)
    for_facebook(auth).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name, user.last_name = auth.info.name.split(' ')
    end
  end
end
