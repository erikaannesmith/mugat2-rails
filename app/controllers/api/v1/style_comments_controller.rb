class Api::V1::StyleCommentsController < ApplicationController

  def index
    style_comments = StyleComment.where(style_id: params[:style_id])
    render json: style_comments
  end

  def create
    style_comment = StyleComment.new(style_comment_params)
    if style_comment.save
      render json: style_comment
    else
      render json: style_comment.errors, status: 400
    end
  end

  def destroy
    style_comment = StyleComment.find_by(style_id: params[:style_id], id: params[:id])
    if style_comment
      style_comment.destroy
      render json: {}, status: :no_content
    else
      render json: {"Error": "Style Comment could not be found"}, status: 404
    end
  end

  private

  def style_comment_params
    params.require(:style_comment).permit(:date, :body, :style_id)
  end

end