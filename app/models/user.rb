class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w.-]+@[\w_\-\.+]+\.\w+\z/}
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A[A-Za-z_\d]+\z/}
end
