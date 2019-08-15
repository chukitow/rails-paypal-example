class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  delegate :name, :price, to: :product, prefix: true

  def subtotal
    product_price * quantity
  end

  def update_product!
    increment!(:quantity)
  end
end
