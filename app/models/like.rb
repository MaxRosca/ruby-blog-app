class Like < ApplicationRecord
  belongs_to :comment, required: false
  belongs_to :article, required: false
end
