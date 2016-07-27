class AddressForm < Rectify::Form
  attribute :id, Integer
  attribute :first_name, String
  attribute :last_name, String
  attribute :street, String
  attribute :zipcode, Integer
  attribute :city, String
  attribute :phone, String
  attribute :country_id, Integer
  attribute :type, Symbol

  validates :phone, phony_plausible: true
  validates :first_name,
            :last_name,
            :street,
            :zipcode,
            :city,
            :phone,
            :country_id,
            :type,
            presence: true
end