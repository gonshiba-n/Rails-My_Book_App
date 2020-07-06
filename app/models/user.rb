class User < ApplicationRecord
  has_many :contents, dependent: :destroy
  has_one_attached :user_image, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  validate :validate_user_image

  validates :name, presence: true
  validates :name, length: { maximum: 35 }

  validates :introduction, length: { maximum: 160 }

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :confirmable

  def validate_user_image
    return unless user_image.attached? # ファイルがアタッチされていない場合は何もしない
    if user_image.blob.byte_size > 10.megabytes
      user_image.purge # アタッチされたファイルの削除
      errors.add(:user_image, 'ファイルのサイズが大きすぎます')
    elsif !image?
      user_image.purge # アタッチされたファイルの削除
      errors.add(:user_image, 'ファイルが対応している画像データではありません')
    end
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  private

  def image?
    %w(image/jpg image/jpeg image/gif image/png).include?(user_image.blob.content_type)
  end
end
