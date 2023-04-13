class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :course, presence: true, length: { maximum: 40 }
  validates :game_date, presence: true, length: { maximum: 40 }
  validates :slope, presence: true, numericality: true, length: { minimum: 2, maximum: 3 }
  validates :rating, presence: true, numericality: true, length: { minimum: 2, maximum: 4 }
  validates :score, presence: true, numericality: true, length: { minimum: 2, maximum: 3 }


end
