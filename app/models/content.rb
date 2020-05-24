class Content < ApplicationRecord
    has_one_attached :image

    validates :name, presence: true
    validates :name, length: {maximum: 35}

    validates :url, presence: true


    validates :private, presence: true
    validates :private, length: {maximum: 1}
    validates :private, numericality: true
end
