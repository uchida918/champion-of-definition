class UserDefinitionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_definition, only: [:new, :create]
  before_action :set_user_definition, only: [:edit, :update, :destroy]
  before_action :reject_admin_and_definition_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @user_definition = current_user.user_definitions.build(definition_id: @definition.id)
  end
  
  def create
    @user_definition = current_user.user_definitions.build(user_definition_params)
    @user_definition.definition_id = @definition.id
    if @user_definition.save
      flash[:success] = '定義を登録しました！'
      redirect_to @definition
    else
      flash.now[:danger] = "定義の登録に失敗しました！"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    p "*********"
    p @user_definition.id
    p params[:user_definition][:custom_body]
    if @user_definition.update(user_favorite_params) && params[:user_definition][:custom_body].nil?
      render :update
    elsif params[:user_definition][:custom_body].blank?
      @user_definition.destroy
      redirect_to @definition
    elsif @user_definition.update(user_definition_params)
      flash[:success] = '定義を変更しました！'
      redirect_to @definition

    else
      flash.now[:danger] = "定義の変更に失敗しました！"
      render :edit
    end
  end
  
  def destroy
    @user_definition.destroy
    flash[:success] = '定義を削除しました！'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def user_definition_params
    params.require(:user_definition).permit(:custom_body)
  end
  
  def user_favorite_params
    params.require(:user_definition).permit(:favorite, :memory)
  end
  
  def set_definition
    @definition = Definition.find(params[:definition_id])
  end

  def set_user_definition
    @user_definition = UserDefinition.find(params[:id])
    @definition = Definition.find(@user_definition.definition_id)
  end

  def correct_user
    redirect_to root_url if !@user_definition.user && @user_definition.user != current_user
  end

  def reject_admin_and_definition_user
    redirect_to root_url if admin?(current_user) || (!admin?(current_user) && @definition.user == current_user)
  end
end

