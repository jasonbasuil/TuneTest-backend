require 'rest-client'

class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :image, :country, :spotify_url, :href, :uri, :spotify_id, :access_token, :refresh_token, :has_playlist, :playlist_id)
  end
end
