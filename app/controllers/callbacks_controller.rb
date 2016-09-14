class CallbacksController < ApplicationController

  def twitter
    user = User.find_or_create_from_twitter request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in with Twitter!"
  end

end
