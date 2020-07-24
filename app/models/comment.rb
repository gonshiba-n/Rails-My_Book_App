class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :content

  has_many :notifications, dependent: :destroy
end
