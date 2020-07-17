class User < ApplicationRecord
  has_many :contents, dependent: :destroy
  has_one_attached :user_image, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :contents
  has_many :favorites, dependent: :destroy
  has_many :fav_content, through: :favorites, source: :content

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
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    # オブジェクトとしてother_userを含んでいるのでinclude?を使用(Viewにてインスタンス作成している)
    followings.include?(other_user)
  end

  def like(content)
    favorites.find_or_create_by(content_id: content.id)
  end

  def unlike(content)
    favorite = favorites.find_by(content_id: content.id)
    favorite.destroy if favorite
  end

  def like?(content)
    # each文から値を取得しているためインスタンスからの取得ではない
    favorites.exists?(content_id: content.id)
  end

  private

  def image?
    %w(image/jpg image/jpeg image/gif image/png).include?(user_image.blob.content_type)
  end
end
