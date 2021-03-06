class Api::V1::AuthController < ApplicationController

  #initial request to Spotify's authorization flow
  def spotify_request
    url = "https://accounts.spotify.com/authorize"
    query_params = {
      client_id: Rails.application.credentials[Rails.env.to_sym][:spotify][:client_id],
      response_type: 'code',
      redirect_uri: 'http://localhost:3000/api/v1/user',
      scope: "user-library-read
      playlist-read-collaborative
      playlist-modify-private
      user-modify-playback-state
      user-read-private
      user-top-read
      playlist-modify-public
      user-read-recently-played
      user-read-playback-state
      user-read-currently-playing",
     show_dialog: true
    }
    redirect_to "#{url}?#{query_params.to_query}"
  end
end
