class RenameUrlToImageUrl < ActiveRecord::Migration[7.1]
  def change
    rename_column :lists, :url, :img_url
  end
end
