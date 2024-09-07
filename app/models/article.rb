class Article < ApplicationRecord
  include Visible
  # mixin with Visible, inherits the methods and properties

  # has a one to many relationship with comment, an article has
  # multiple comments. When article deleted remove it's comments as well
  has_many :comments, dependent: :destroy

  # must have a title
  validates :title, presence: true

  # must have a body
  validates :body, presence: true, length: { minimum: 10 }
end
