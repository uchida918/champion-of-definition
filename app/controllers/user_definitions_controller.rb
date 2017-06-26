class DefinitionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :set_user_definition, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @definition = Definition.find(params[:definition_id])
    current_user.user_definitions.build(definition_id: @definition.id)
  end
  
  def create
    @definition = Definition.find(params[:definition_id])
    @user_definition = current_user.user_definitions.build(user_definition_params)
    @user_definition.definition_id = @definition.id
    if @user_definition.save
      flash[:success] = '定義を登録しました！'
      redirect_to root_url
    else
      @user_definitions = current_user.user_definitions.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "定義の登録に失敗しました！"
      render 'toppages/index'
    end
  end
  
  def edit
  end
  
  def update
    if @user_definition.update(user_definition_params)
      flash[:success] = '定義を変更しました！'
      redirect_to root_url
    else
      @user_definitions = User_definitions.order('created_at DESC').page(params[:page])
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
  
  def set_user_definition
    @user_definition = User_definitions.find(params[:id])
  end

  def correct_user
    redirect_to root_url if @user_definition.user != current_user
  end
end

