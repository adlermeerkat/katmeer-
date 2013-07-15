# ----------------------------------------------------- This controls the page for signing up 
# ----------------------------------------------------- (creating a new user in the USER MODEL (user.rb))



class UsersController < ApplicationController
before_filter :signed_in_user, only: [:edit, :update]
before_filter :correct_user,   only: [:edit, :update]

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



  private


# ----------------------------------------------------- Signed_in_user for authorization.
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
end
