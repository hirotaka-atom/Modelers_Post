class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :image
      t.text :content
      t.references :user, foreign_keys: true
      t.references :post, foeign_keys: true

      t.timestamps
    end
  end
end
