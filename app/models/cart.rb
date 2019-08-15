class Cart < ApplicationRecord
  has_many :line_items

  def add_or_update_line_item!(line_item)
    line_item = line_items.find_or_initialize_by(
      product_id: line_item[:product_id]
    )

    if line_item.new_record?
      line_item.save
    else
      line_item.increment!(:quantity)
    end
  end

  def total
    line_items.joins(:product).sum('products.price * line_items.quantity')
  end
end
