# == Schema Information
#
# Table name: statements
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Statement < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  belongs_to :user

  # ----------------------------------------------------- Scope
  default_scope -> { order('created_at DESC') }

  # ----------------------------------------------------- Validations
  validates :user_id, presence: true
end
