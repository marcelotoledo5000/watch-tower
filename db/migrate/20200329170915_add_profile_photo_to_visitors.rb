class AddProfilePhotoToVisitors < ActiveRecord::Migration[6.0]
  def change
    add_column :visitors, :profile_photo, :string, null: false
  end
end
