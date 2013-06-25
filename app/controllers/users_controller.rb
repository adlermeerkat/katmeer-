#This controls the page for signing up (creating a new user in the USER MODEL (user.rb))

class UsersController < ApplicationController

	def show
		#defining the @user variable for the show page!
		@user= User.find(params[:id])
	end

  def new
  	#defining the @user variable for the form at new.html.erb
  	@user= User.new
	end

	#This part controls what happens when creating a new user using the Sign Up form (First part is success, second is failed)
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

# Here are the edit pages: #####################################################################################################

  def edit
    @user = User.find(params[:id])
	  case params[:form]
	  when "email"
	    render 'email'
	  when "password"
	    render 'password'
	  else
	    render :action => :edit
	  end
	end


end
