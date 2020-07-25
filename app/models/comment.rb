class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :content

  has_many :notifications, dependent: :destroy

  # バリデーション===========================
  validates :user_id, presence: true
  validates :content_id, presence: true
  validates :comment, presence: true, length: { maximum: 160 }
end
