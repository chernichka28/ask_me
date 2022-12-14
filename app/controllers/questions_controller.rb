class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update edit hide]
  before_action :set_question_for_current_user, only: %i[update edit hide]

  def create
    question_params = params.require(:question).permit(:body, :user_id)
    if current_user.present?
      question_params[:author_id] = current_user.id
    end
    @question = Question.create(question_params)
    @user = User.find(params[:question][:user_id])

    if @question.save
      redirect_to user_path(@question.user), notice: "Вы создали новый вопрос!"
    else
      flash.now[:alert] = "Вы неправильно заполнили поля формы вопроса!"

      render :new
    end

  end

  def update
    question_params = params.require(:question).permit(:body, :answer)
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
    @questions = Question.order("created_at DESC")
  end

  def new
    @user = User.find(params[:user_id])
    @question = Question.new(user: @user)
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
end
