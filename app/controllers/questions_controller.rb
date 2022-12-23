class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update edit hide]
  before_action :set_question_for_current_user, only: %i[update edit hide]

  def create
    question_params = params.require(:question).permit(:body, :user_id)
    if current_user.present?
      question_params[:author_id] = current_user.id
    end
    @question = Question.new(question_params)

    hashtags_arr = @question.body.scan(/#[\wА-Яа-я\-]+/i)
    hashtags_arr = hashtags_arr.map { |h| h.downcase }

    if @question.save
      @question.hashtags = set_hashtags_arr(hashtags_arr) unless hashtags_arr.empty?

      redirect_to user_path(@question.user), notice: "Вы создали новый вопрос!"
    else
      flash.now[:alert] = "Вы неправильно заполнили поля формы вопроса!"

      render :new
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    hashtags_arr = question_params[:body].scan(/#[\wА-Яа-я\-]+/i)
    hashtags_arr += question_params[:answer].scan(/#[\wА-Яа-я\-]+/i)
    hashtags_arr = hashtags_arr.map { |h| h.downcase }
    question_params[:hashtags] = set_hashtags_arr(hashtags_arr) unless hashtags_arr.empty?

    @question.update(question_params)

    redirect_to user_path(@question.user), notice: "Вы изменили вопрос!"
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to root_path, notice: "Вы удалили вопрос!"
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @question = Question.new
    @questions = Question.order(created_at: :desc).take(10)
    @users = User.order(created_at: :desc).take(10)
  end

  def new
    @question = Question.new(user_id: params[:user_id])
  end

  def edit
  end

  def hide
    @question.update(hidden: true)

    redirect_to user_path(@question.user), notice: "Вы скрыли вопрос!"
  end

  private

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end

  def set_hashtags_arr(arr)
    arr.map do |h|
      Hashtag.find_or_create_by(name: h)
    end
  end
end
