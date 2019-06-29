class CreateUsers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :repos
    end
  end
end
