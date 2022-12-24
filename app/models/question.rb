class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true
  has_many :question_hashtags
  has_many :hashtags, through: :question_hashtags

  validates :body, presence: true, length: { maximum: 280 }
  before_save :set_hashtags

  private

  def set_hashtags
    hashtags = self.body.scan(/#[\wА-Яа-я\-]+/i)
    hashtags += self.answer.scan(/#[\wА-Яа-я\-]+/i) if self.answer.present?
    hashtags = hashtags.map do |hashtag|
      hashtag = hashtag.downcase
      Hashtag.find_or_create_by(name: hashtag)
    end
    self.hashtags.delete_all
    QuestionHashtag.where(question_id: self.id).delete_all
    self.hashtags = hashtags
  end
end
