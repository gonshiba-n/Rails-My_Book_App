class User < ApplicationRecord
  has_many :contents
  has_one_attached :user_image

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

  private

  def image?
    %w(image/jpg image/jpeg image/gif image/png).include?(user_image.blob.content_type)
  end
end
