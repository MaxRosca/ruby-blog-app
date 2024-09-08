class AddUserToArticles < ActiveRecord::Migration[7.2]
  def change
    add_reference :articles, :user, foreign_key: { to_table: :users }
  end
end
