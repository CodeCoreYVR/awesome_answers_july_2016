class Api::BaseController < ApplicationController
  before_action :authenticate_api_user

  # this means that if the user is making non-GET request (POST / PATCH / DELETE..etc)
  # and the user doesn't supply an authenticity_token. Rails will make the session
  # empty. Meaning that it will clear the cookies for that request.
  protect_from_forgery with: :null_session

  private

  def authenticate_api_user
    head :unauthorized unless current_api_user
  end

  def current_api_user
    @current_api_user = User.find_by_api_key params[:api_key]
  end

end
