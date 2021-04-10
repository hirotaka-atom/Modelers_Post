class CreateBravos < ActiveRecord::Migration[6.1]
  def change
    create_table :bravos do |t|
      t.references :bravo_tag, foreign_keys: true
      t.references :user, foreign_keys: true
      t.references :post, foreign_keys: true

      t.timestamps
    end
  end
end
