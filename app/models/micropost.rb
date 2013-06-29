class Micropost < ActiveRecord::Base
  attr_accessible :bark, :user_id, :vote

  # Validations:
  validates :user_id, presence: true
end
