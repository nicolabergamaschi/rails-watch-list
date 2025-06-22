class ListsController < ApplicationController
  def index
    @lists = List.all
    @reviews = Reviews.all
  end

  def show
    @list = List.find(params[:id])
    @review = Review.new  # Empty review for the form
    @reviews = @list.reviews  # Get reviews for this specific list
  end

  def new
    @lists = List.all
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

    def review_params
    params.require(:review).permit(:comment, :rating)
  end

end
