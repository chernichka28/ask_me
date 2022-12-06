class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update show destroy edit hide]

  def create
    question = Question.create(question_params)

    redirect_to question_path(question), notice: "Вы создали новый вопрос!"
  end

  def update
    @question.update(question_params)

    redirect_to question_path(@question), notice: "Вы изменили вопрос!"
  end

  def destroy
    @question.destroy

    redirect_to questions_path, notice: "Вы удалили вопрос!"
  end

  def show
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def hide
    @question.update(hidden: true)

    redirect_to questions_path, notice: "Вы скрыли вопрос!"
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
