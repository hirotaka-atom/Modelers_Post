class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.string :email
      t.string :password_digest
      t.string :admin


      t.timestamps
    end
  end
end
