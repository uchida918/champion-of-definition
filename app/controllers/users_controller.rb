class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @definitions = @user.definitions
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.save
      flash[:success] = 'ユーザ情報を変更しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユー情報ザの変更に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @user.destroy

    flash[:success] = 'ユーザーは正常に削除されました'
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    redirect_to(current_user || root_url) if @user != current_user
  end
end
