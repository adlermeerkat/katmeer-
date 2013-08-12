class SessionsController < ApplicationController
  before_filter :not_signed_in_user, only: :new

# ----------------------------------------------------- Controller for signing users in. 

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

# ----------------------------------------------------- Signed_in_user for authorization.
    def not_signed_in_user
      if signed_in?
        redirect_to current_user
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
