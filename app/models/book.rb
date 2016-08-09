class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :order_items

  validates_presence_of :title,
            :short_description,
            :full_description,
            :image,
            :instock,
            :price

  validates :price, numericality: { grater_than: 0 }

  validates :instock, numericality: { grater_than_or_equal_to: 0 }

  scope :all_instock, -> { where(instock: 1..Float::INFINITY) }
  scope :most_popular_books, -> (count = 3) { all_instock
    .group_by{ |book| book.order_items.map(&:quantity).sum }
    .max_by(count){ |key, value| key }.transpose[1].flatten.first(count) }

  def sold_books quantity
    self.instock -= quantity
    save
  end
end
