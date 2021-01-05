# frozen_string_literal: true

class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    customer_id = get_customer(params[:stripeToken])
    subscription = Stripe::Subscription.create({ customer: customer_id, plan: 'demo_subscription' })

    test_env?(customer_id, subscription)
    status = Stripe::Invoice.retrieve(subscription.latest_invoice).paid

    if status
      current_user.update_attribute(:role, 'subscriber')
      render json: { message: 'You are now a subscriber!' }, status: 201
    else
      render_stripe_error('Something went wrong.')
    end
  rescue StandardError => e
    current_user.update_attribute(:role, 'registered_user')
    render_stripe_error(e.message)
  end

  private

  def get_customer(stripe_token)
    customer = Stripe::Customer.list(email: current_user.email).data.first
    customer ||= Stripe::Customer.create({ email: current_user.email, source: stripe_token })
    customer.id
  end

  def test_env?(customer, subscription)
    if Rails.env.test?
      invoice = Stripe::Invoice.create({ customer: customer, subscription: subscription.id, paid: true })
      subscription.latest_invoice = invoice.id
    end
  end

  def render_stripe_error(error)
    render json: { message: "Transaction was not successfull. #{error}" }, status: 422
  end
end
