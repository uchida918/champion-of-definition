class DefinitionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @definition = Definition.find(params[:definition_id])
    current_user.user_definitions.build(definition_id: @definition.id)
  end
  
  def create
    @definition = Definition.find(params[:definition_id])
    @user_definition = current_user.user_definitions.build(user_definition_params)
    current_user.user_definitions.build(definition_id: @definition.id)
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
    @user_definition = User_definition.find(params[:id])
  end
  
  def update
    @user_definition = User_definition.find(params[:id])
     
    if @user_definition.update
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
  
  def correct_user
    @user_definition = current_user.user_definitions.find_by(id: params[:id])
    unless @user_definition
      redirect_to root_path
    end
  end
  
end

