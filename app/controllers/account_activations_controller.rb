class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      begin
        ActiveRecord::Base.transaction do
          user.update_attribute(:activated,    true)
          user.update_attribute(:activated_at, Time.zone.now)
          user.activate
          user.create_first_signin_notification
          log_in user
          flash[:success] = "Account activated!"
          redirect_to user
        end
      rescue => e
        flash[:danger] = "Invalid activation link"
        redirect_to root_url
      end
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
