class CreateBravos < ActiveRecord::Migration[6.1]
  def change
    create_table :bravos do |t|
      t.integer :bravo_tag_id
      t.integer :user_id
      t.integer :post_id
      
      t.timestamps
    end
  end
end
