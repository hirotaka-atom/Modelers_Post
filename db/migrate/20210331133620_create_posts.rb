class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, default: 'タイトルなし'
      t.references :post_tag, foreign_keys: true
      t.string :image
      t.text :content
      t.integer :user_id
      t.integer :impressions_count, default: 0

      t.timestamps
    end
  end
end
