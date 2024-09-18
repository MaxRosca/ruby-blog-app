module Likeable extend ActiveSupport::Concern
  # method removes a like if the user gave a like to the likable entity
  # or adds a like if the user didn't give one yet
  # returns true if action succeded
  # returns false if failed
  def like(user_id)
    like = self.likes.find { |like2| like2.user_id == user_id }

    if like
      like.destroy
      true
    else
      like = self.create_like(user_id)

      if like.persisted?
        true
      else
        false
      end
    end
  end

  def create_like(user_id)
    raise AbstractMethodError.new(self.class, __method__)
  end
end
