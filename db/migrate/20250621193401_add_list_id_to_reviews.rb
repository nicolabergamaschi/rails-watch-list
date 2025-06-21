class AddListIdToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :list_id, :integer
  end
end
