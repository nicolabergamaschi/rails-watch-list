class BookmarksController < ApplicationController
  before_action :find_list

  def new
    @bookmark = Bookmark.new
    @movies = Movie.all
  end

  def create
    @bookmark = @list.bookmarks.build(bookmark_params)
    @movies = Movie.all

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
