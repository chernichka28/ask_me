class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  validates :body, presence: true, length: { maximum: 280 }
  after_save :set_hashtags

  private

  def set_hashtags
    self.hashtags =
      "#{body} #{answer}".downcase.scan(Hashtag::REGEX).uniq.map do |hashtag|
        Hashtag.find_or_create_by(name: hashtag.downcase)
      end
  end
end
