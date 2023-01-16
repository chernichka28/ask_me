class Hashtag < ApplicationRecord
  REGEX = (/#[\p{L}\d_]+/).freeze

  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  validates :name, uniqueness: true
end
