class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def show
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find_by!(name: params[:name])
    @questions_with_this_hashtag = @hashtag.questions.uniq
  end
end
