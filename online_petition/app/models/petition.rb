class Petition < ActiveRecord::Base
  EXPIRED_PERIOD_DAYS = 30
  WIN_VOTES_NUM = 100

  belongs_to :user
  has_many :votes, dependent: :destroy

  scope :expired, -> { where('created_at < ?', (DateTime.now - EXPIRED_PERIOD_DAYS)) }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 256 }
  validates :text, presence: true, length: { maximum: 2000 }

  def win?
    self.votes.count >= min_votes_num
  end

  def min_votes_num
    WIN_VOTES_NUM
  end

  def become_expired?
    Petition.expired.include? self
  end
end
