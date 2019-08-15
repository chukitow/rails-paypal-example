class LineItemsController < ApplicationController
  def index
    @line_items = current_cart.line_items
  end

  def create
    current_cart.add_or_update_line_item!(line_item_params)
    redirect_to line_items_path
  end

  def destroy
    line_item = LineItem.find(params[:id])
    line_item.destroy

    redirect_to line_items_path
  end

  private

  def line_item
  end

  def line_item_params
    params.require(:line_item).permit(:product_id, :quantity)
  end
end
