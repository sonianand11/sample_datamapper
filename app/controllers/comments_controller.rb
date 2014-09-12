class CommentsController < ApplicationController
  before_filter :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.search params[:picture_id]
  end

  def create
    @comment = Comment.new(params[:comment])
    respond_to do |format|
      if @comment.save
        Comment.store_to_elasticsearch @comment
        format.js
      else
        format.js { render :js => "alert('Problem in saving comment')"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.get(params[:id])
    end
end
