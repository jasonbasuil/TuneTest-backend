class Api::V1::SessionsController < ApplicationController

  def new
  end

  def create

    # need to figure out session
    # user = User.find_by(id: params[:id])
    # session[:id] = user.id

    redirect_to "http://localhost:3001/app"
  end

  def destroy
    session.clear
    flash[:message] = "You have successfully logged out"
    redirect_to root_path
  end
end
