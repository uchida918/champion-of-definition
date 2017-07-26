class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :constitution, :civil_code, :criminal_code, :notebook]
  before_action :correct_user, only: [:show, :edit, :update, :destroy, :constitution, :civil_code, :criminal_code, :notebook]

  def show
    @definitions = Definition.where(user_id: referenceable_ids)
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
      flash.now[:danger] = 'ユーザ情報の変更に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @user.destroy

    flash[:success] = 'ユーザーは正常に削除されました'
    redirect_to root_url
  end
  
  def constitution
    area = Area.find_by(name: "憲法")
    category_ids = Category.where(area_id: area.id).pluck(:id)
    @definitions = Definition.where(category_id: category_ids, user_id: referenceable_ids)
    render :show
  end

  def civil_code
    area = Area.find_by(name: "民法")
    category_ids = Category.where(area_id: area.id).pluck(:id)
    @definitions = Definition.where(category_id: category_ids, user_id: referenceable_ids)
    render :show
  end
  
  def criminal_code
    area = Area.find_by(name: "刑法")
    category_ids = Category.where(area_id: area.id).pluck(:id)
    @definitions = Definition.where(category_id: category_ids, user_id: referenceable_ids)
    render :show
  end
  
  def notebook
    @definitions = @user.favorite_definitions
    render :show
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
