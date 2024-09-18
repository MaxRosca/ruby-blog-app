class Comment < ApplicationRecord
  include Visible, Likeable

  belongs_to :article
  belongs_to :user
  has_many :likes, dependent: :destroy

  def create_like(user_id)
    self.likes.create(user_id: user_id, comment_id: self.id)
  end
end
