class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :petition

  # validates_uniqueness_of :vote_id, scope: [:user_id, :petition_id]

  validates :user_id, presence: true
  validates :petition_id, presence: true
end
