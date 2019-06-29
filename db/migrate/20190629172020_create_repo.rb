class CreateRepo < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
