class AddPlaceToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :place, :string
  end
end
