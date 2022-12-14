class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_path, notice: "Вы успешно зарегистрировались и вошли!"
    else
      flash.now[:alert] = "Вы неправильно заполнили поля формы регистрации!"

      render :new
    end

  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Ваши данные обновлены!"
    else
      flash.now[:alert] = "При попытке сохранить измнения возникли ошибки."

      render :edit
    end
  end

  def destroy
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: "Пользователь удалён!"
  end

  def show
    @questions = @user.questions.order("created_at DESC")
    @question = Question.new(user: @user)
  end

  private

  def authorize_user
    redirect_with_alert if current_user != @user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :color)
  end
end
