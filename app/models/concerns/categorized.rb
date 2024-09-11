module Categorized extend ActiveSupport::Concern
  VALID_CATEGORIES = [ "Nature", "Sport", "Personal Life", "Study", "Travel" ]

  included do
        validates :category, inclusion: { in: Categorized::VALID_CATEGORIES }
  end
end
