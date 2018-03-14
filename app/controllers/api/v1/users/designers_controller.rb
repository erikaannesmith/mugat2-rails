class Api::V1::Users::DesignersController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Designer.where(user: current_user)
  end

  def show
    designer = Designer.find_by(id: params[:id])
    if designer
      render json: designer
    else
      render json: {"Error": "Designer not found"}, status: 404
    end
  end

  def create
    designer = Designer.new(designer_params)
    if designer.save
      render json: designer
    else
      render json: designer.errors, status: 400
    end
  end

 private 

  def designer_params
    params.require(:designer).permit(:company, :contact, :phone, :email, :user_id)
  end

end