class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :post_tag_id
      t.string :image
      t.text :content
      t.integer :user_id
      
      t.timestamps
    end
  end
end
