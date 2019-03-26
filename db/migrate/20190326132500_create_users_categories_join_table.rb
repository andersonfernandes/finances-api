class CreateUsersCategoriesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :categories do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end
