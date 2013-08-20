class StatementsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  def index
  end

  def create
    @statement = current_user.statements.build(statement_params)
    if @statement.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def new
  	@statement = current_user.statements.build if signed_in?
  end

  private

    def statement_params
      params.require(:statement).permit(:content)
    end
end
