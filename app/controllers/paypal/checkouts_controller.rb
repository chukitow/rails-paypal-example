class Paypal::CheckoutsController < ApplicationController
  include PayPal::SDK::REST

  def create
    payment = Payment.new({
      intent: 'sale',
      payer: {
        payment_method: 'paypal'
      },
      redirect_urls: {
        return_url: complete_paypal_checkouts_url,
        cancel_url: line_items_url
      },
      transactions:  [
        {
          amount: {
            total: current_cart.total,
            currency: 'MXN',
          },
          description: 'Pago de productos',
          item_list: {
            items: current_cart.line_items.map(&:to_paypal)
          }
        },
      ]
    })

    if payment.create
      redirect_url = payment.links.find{|v| v.rel == "approval_url" }.href

      redirect_to redirect_url
    else
      redirect_to line_items_path, alert: 'Something went wrong, please try later'
    end
  end

  def complete
    payment = Payment.find(params[:paymentId])

    if payment.execute(payer_id: params[:PayerID])  #return true or false
      session[:cart_id] = nil
      redirect_to root_path, notice: 'Thanks for purchasing!'
    else
      redirect_to line_items_path, alert: 'There was a problem processing your payment'
    end
  end
end
