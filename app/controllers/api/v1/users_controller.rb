require 'rest-client'

class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  def create
    # Request refresh and access tokens
    body = {
      grant_type: "authorization_code",
      code: params[:code],
      redirect_uri: 'http://localhost:3000/api/v1/user',
      client_id: Rails.application.credentials[Rails.env.to_sym][:spotify][:client_id],
      client_secret: Rails.application.credentials[Rails.env.to_sym][:spotify][:client_secret]
    }

    auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
    auth_params = JSON.parse(auth_response.body)
    header = {
      Authorization: "Bearer #{auth_params["access_token"]}"
    }

    user_response = RestClient.get("https://api.spotify.com/v1/me", header)
    user_params = JSON.parse(user_response.body)

    # Create User from user_params
    @user = User.find_or_create_by(
      name: user_params["display_name"],
      spotify_url: user_params["external_urls"]["spotify"],
      href: user_params["href"],
      uri: user_params["uri"],
      spotify_id: user_params["id"])

    # Checks if a user has an image on their Spotify account
    image = user_params["images"][0] ? user_params["images"][0]["url"] : nil
    country = user_params["country"] ? user_params["country"] : nil

    # Update user if they have image or country
    @user.update(image: image, country: country)

    #Update the user access/refresh_tokens
    if @user.access_token_expired?
      @user.refresh_access_token
    else
      @user.update(
        access_token: auth_params["access_token"],
        refresh_token: auth_params["refresh_token"])
    end

    # Redirect to the frontend App homepage
    redirect_to "http://localhost:3001/app"
  end

  # Update user once a new playlist has been created for them
  def update
    @user = User.find_by(id: params[:id])
    puts "playlist_id",  params[:playlist_id]
    puts "params[:id]",  params[:id]
    @user.update(has_playlist: true, playlist_id: params["playlist_id"])
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :image, :country, :spotify_url, :href, :uri, :spotify_id, :access_token, :refresh_token, :has_playlist, :playlist_id)
  end
end
