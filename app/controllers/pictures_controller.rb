class PicturesController < ApplicationController
  before_filter :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all.page params[:page]
  end

  def show
    @comment = Comment.new(:picture_id => @picture.id)
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(params[:picture])

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.get(params[:id])
    end
end
