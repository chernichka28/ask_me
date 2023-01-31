class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def show
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
    @questions_with_this_hashtag = @hashtag.questions.uniq
  end
end
