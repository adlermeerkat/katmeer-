# ----------------------------------------------------- This controls the page for signing up 
# ----------------------------------------------------- (creating a new user in the USER MODEL (user.rb))



class UsersController < ApplicationController
before_filter :signed_in_user, only: [:index, :edit, :update, :delete]
before_filter :correct_user,   only: [:edit, :update, :show]
before_filter :admin_user,     only: :destroy
# before_filter :not_signed_in_user, only: :new

	def show
# ----------------------------------------------------- Defining the @user variable for the show page!
		@user= User.find(params[:id])
	end




  def new
# ----------------------------------------------------- Defining the @user variable for the form at new.html.erb
  	@user= User.new
	end



# ----------------------------------------------------- This part controls what happens when creating a new user 
# ----------------------------------------------------- using the Sign Up form (First part is success, second is failed)
	def create
	   @user = User.new(params[:user])
	   if @user.save
	   	sign_in @user
	   	flash[:success] = "Welcome to Katmeer!"
	   	redirect_to root_path
	   else
	     render 'new'
	    end
	end



# ----------------------------------------------------- These are the edit pages.
  def edit
#    @user = User.find(params[:id])
#	  case params[:form]
#		  when "email"
#		    render 'email'
#		  when "password"
#		    render 'password'
#		  else
#		    render :action => :edit
#	  end
	end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end



# ----------------------------------------------------- This is the index page.
  def index
    @users = User.paginate page: params[:page],
                            :order => 'username'
    respond_to do |format|
      format.html
      format.js # add this line for your js template
    end
  end
#    @users = User.order(:username).page params[:page]

# ----------------------------------------------------- This is for deleting users.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private

# ----------------------------------------------------- Signed_in_user for authorization.
    def not_signed_in_user
      if signed_in?
        redirect_to current_user
      end
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
