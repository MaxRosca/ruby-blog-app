class CreateLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :likes do |t|
      t.timestamps
      t.references :user, foreign_key: { to_table: :users }
      t.references :article, foreign_key: { to_table: :articles }
      t.references :comment, foreign_key: { to_table: :comments }
    end
  end
end
