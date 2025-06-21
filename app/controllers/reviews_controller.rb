class ReviewsController < ApplicationController
  before_action :find_list

  def index
    @reviews = Review.all
  end

  def create
    @review = @list.reviews.build(review_params)
    if @review.save
      redirect_to list_path(@list), notice: 'Review was successfully added!'
    else
      # If there are errors, re-render the list show page with errors
      @list = List.find(params[:list_id])  # Reload for the view
      render 'lists/show', status: :unprocessable_entity
    end
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
