class AddParentCategoryToCategories < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories,
                  :parent_category,
                  foreign_key: { to_table: :categories }
  end
end
