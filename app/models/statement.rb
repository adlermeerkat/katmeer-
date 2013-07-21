class Statement < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user

  # ----------------------------------------------------- Scope
  default_scope -> { order('created_at DESC') }

  # ----------------------------------------------------- Validations
  validates :user_id, presence: true
end
