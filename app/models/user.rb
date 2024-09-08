class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates_format_of :email,  with: /\A[^@\s]+@[^@\s]+\z/, message: "Must be a valid email address"
  validates :password_digest, presence: true
end
