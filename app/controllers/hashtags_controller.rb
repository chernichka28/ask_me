class HashtagsController < ApplicationController
  before_action :check_data, only: [:show]

  def show
  end

  def create
    @hashtag = Hashtag.new(hashtag_params)
    @hashtag.save
  end

  private
    def check_data
      @hashtag.destroy if Hashtag.find(params[:id]).questions.count == 0
      @hashtag = Hashtag.find(params[:id])
      @questions_with_this_hashtag = @hashtag.questions.uniq
    end

    def hashtag_params
      params.fetch(:hashtag, {})
    end
end
