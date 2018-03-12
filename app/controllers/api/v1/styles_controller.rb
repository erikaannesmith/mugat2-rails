class Api::V1::StylesController < ApplicationController

  def index
    render json: Style.where(designer_id: params[:designer_id])
  end

  def show
    style = Style.find_by(id: params[:id], designer_id: params[:designer_id])
    if style 
      render json: style
    else
      render json: {"Error": "Style not found"}, status: 404
    end
  end

  def create
    style = Style.new(style_params)
    if style.save
      render json: style
    else
      render json: style.errors, status: 400
    end
  end

  private

  def style_params
    params.require(:style).permit(:name, :description, :designer_id)
  end
end