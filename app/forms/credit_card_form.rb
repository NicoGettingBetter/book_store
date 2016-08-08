class CreditCardForm < Rectify::Form
  attribute :number
  attribute :expiration_month
  attribute :expiration_year
  attribute :cvv

  validates :number,
            :expiration_month,
            :expiration_year,
            :cvv,
            presence: true            
  validates :cvv, length: { is: 3 }
  validates :number, length: { is: 16 }
end