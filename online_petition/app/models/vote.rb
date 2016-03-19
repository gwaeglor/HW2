class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :petition
  validates :user_id, presence: true
  validates :petition_id, presence: true
end
