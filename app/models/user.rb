class User < ApplicationRecord
  has_many :questions, dependent: :delete_all

  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w\.-]+@[A-Za-z\d\-\.+]+\.[a-z]+\z/}
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A[A-Za-z_\d]+\z/}

  def downcase_nickname
    nickname.downcase!
  end
end
