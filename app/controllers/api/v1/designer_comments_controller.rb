class Api::V1::DesignerCommentsController < ApplicationController

  def index
    designer_comments = DesignerComment.where(designer_id: params[:designer_id])
    render json: designer_comments
  end

  def create
    designer_comment = DesignerComment.new(designer_comment_params)
    if designer_comment.save
      render json: designer_comment
    else
      render json: designer_comment.errors, status: 400
    end
  end

  def destroy
    designer_comment = DesignerComment.find_by(designer_id: params[:designer_id], id: params[:id])
    if designer_comment
      designer_comment.destroy
      render json: {}, status: :no_content
    else
      render json: {"Error": "Cannot find specified designer comment"}, status: 404
    end
  end

  private

  def designer_comment_params
    params.require(:designer_comment).permit(:date, :body, :designer_id)
  end

end