class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      session[:theme] = "light"

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.save
      redirect_to root_path, notice: "Ваши данные обновлены!"
    else
      flash.now[:alert] = "При попытке сохранить измнения возникли ошибки."

      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)

    redirect_to root_path, notice: "Пользователь удалён!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
