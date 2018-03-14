class Api::V1::UsersController < ApplicationController

  def create
    user = User.from_auth(params[:email])
    render json: user, status: 200
  end

end