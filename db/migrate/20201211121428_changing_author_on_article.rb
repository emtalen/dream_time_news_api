class ChangingAuthorOnArticle < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :author, :string
    add_column :articles, :author_id, :integer, null: false, foreign_key: true 
  end
end
