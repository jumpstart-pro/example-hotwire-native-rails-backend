class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :notification_tokens
  has_many :notifications, as: :recipient

  def self.valid_credentials?(email, password)
    user = find_by(email:)
    user&.valid_password?(password) ? user : nil
  end
end
