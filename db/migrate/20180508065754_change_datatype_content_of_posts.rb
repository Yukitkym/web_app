class ChangeDatatypeContentOfPosts < ActiveRecord::Migration[5.1]
  def change
  	change_column :posts, :content, :string
  end
end
