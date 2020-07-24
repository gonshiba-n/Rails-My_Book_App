class Content < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :users, foreign_key: :favorites

  has_many :comments, dependent: :destroy

  has_many :notifications, dependent: :destroy

  scope :recent, -> { order(updated_at: :desc) }

  validates :name, presence: true
  validates :name, length: { maximum: 35 }

  validates :url, presence: true
  validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  # validates :description, lemgth{ maximum: 160 }

  validates :private, presence: true
  validates :private, length: { maximum: 1 }
  validates :private, numericality: true

  validate :private, :check_private

  def self.ransackable_attributes(auth_object = nil)
    %w(name url description category updated_at)
  end

  def self.ransackble_associations(auth_object = nil)
    []
  end

  def create_notification_favorite!(current_user)
    # DBにすでにお気に入りにされたデータがあるかを格納
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and content_id = ? and action = ?",
      current_user.id,
      user_id,
      id,
      'favorite',
    ])
      # tempが空なら作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          content_id: id,
          visited_id: user_id,
          action: 'favorite'
        )
        # 自分のコンテンツに対するお気に入りは通知済みとしてtrueとしてDBへ格納
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        # バリデーション確認後にDBへセーブする
        notification.save if notification.valid?
      end
  end

  def create_notification_comment!(current_user, comment_id)
    # 、全員に通知を行うため自分以外にコメントしているユーザーを全て取得する
    temp_ids = Comment.select(:user_id).where(content_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合には投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回するため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      content_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分のコンテンツに対するコメントは通知済みとしてtrueとしてDBへ格納
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

  def check_private
    if private == 0 || private.to_i > 3
        errors.add(:private, "が不正な値です")
    end
  end
end
