class HashtagsController < ApplicationController
  before_action :set_hashtag, only: [:show]

  def show
  end

  def create
    @hashtag = Hashtag.new(hashtag_params)
    @hashtag.save
  end

  private
    def set_hashtag
      @hashtag = Hashtag.find(params[:id])
      @questions_with_this_hashtag = @hashtag.questions.uniq
    end

    def hashtag_params
      params.fetch(:hashtag, {})
    end
end
