class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  # TOTEACH:
  # - database transactions
  # - code cleanliness
  # - error handling
  def create
    if current_course.premium?
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => current_course.stripe_cost,
        :description => 'Flixter Course Premium Content',
        :currency    => 'usd'
      )
      # I would say this is not necessarily the best solution because it's not clear. It would be simple enough just to make a transaction.
    end
    current_user.enrollments.create(course:current_course)
    redirect_to course_path(current_course)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to course_path(current_course)
  end

  private
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
end
