class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_many :question_hashtags
  has_many :hashtags, through: :question_hashtags

  validates :body, presence: true, length: { maximum: 280 }
  before_save :set_hashtags

  private

  def set_hashtags
    self.hashtags.delete_all
    QuestionHashtag.where(question_id: id).delete_all

    new_hashtags = body.scan(Hashtag.regex)
    new_hashtags += answer.scan(Hashtag.regex) if answer.present?

    self.hashtags = new_hashtags.map do |hashtag|
      Hashtag.find_or_create_by(name: hashtag.downcase)
    end
  end
end
