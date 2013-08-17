# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Statement < ActiveRecord::Base
  attr_accessible :content, :user_id
  belongs_to :user

  # ----------------------------------------------------- Scope
  default_scope -> { order('created_at DESC') }

  # ----------------------------------------------------- Validations
  validates :content, presence: true, length: {maximum: 1000}
  validates :user_id, presence: true

end
