class ApplicationController < ActionController::Base
  helper_method :current_cart

  protected

  def current_cart
    return @cart unless @cart.nil?

    cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = cart.id
    cart
  end
end
