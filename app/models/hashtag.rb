class Hashtag < ApplicationRecord
  @@regex = (/#[\p{L}\d_]+/).freeze
  cattr_reader :regex

  has_many :question_hashtags
  has_many :questions, through: :question_hashtags

  validates :name, uniqueness: true
end
