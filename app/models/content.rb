class Content < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    scope :recent, -> {order(updated_at: :desc)}

    validates :name, presence: true
    validates :name, length: {maximum: 35}

    validates :url, presence: true
    validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

    validates :private, presence: true
    validates :private, length: {maximum: 1}
    validates :private, numericality: true

    validate :private, :check_private

    def self.ransackable_attributes(auth_object = nil)
        %w[name url description category updated_at]
    end

    def self.ransackble_associations(auth_object = nil)
        []
    end

    private
    def check_private
        if private == 0 || private.to_i > 3
            errors.add(:private, 'が不正な値です')
        end
    end

end
