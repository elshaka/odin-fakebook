class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read: false).order(created_at: :desc) }

  ICONS = %w[heart comment user-friends].freeze

  validate :icon_is_valid

  def icon_is_valid
    errors.add(:icon, 'is invalid') unless ICONS.include? icon
  end

  def mark_as_read
    update_attribute(:read, true)
  end
end
