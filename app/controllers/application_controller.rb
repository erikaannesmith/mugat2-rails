class ApplicationController < ActionController::Base
  helper_method :current_user, :authenticate_user!

  def current_user
    # token = params[:token]
    # payload = TokiToki.decode(token)
    @current_user ||= User.find(params[:id])
  end

  def logged_in?
    current_user != nil
  end

  def authenticate_user!
    head :unauthorized unless logged_in?
  end

  def index

  end

end
