class DefinitionsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :my_definition, only: :show
  
  def show
    @definition = Definition.find(params[:id])
    @user_definition = @definition.user_definitions.find_by(user_id: current_user.id)
  end
  
  def new
    @definition = current_user.definitions.build
  end
  
  def create
    @definition = current_user.definitions.build(definition_params)
    if @definition.save
      flash[:success] = '定義を登録しました！'
      redirect_to current_user
    else
      @definitions = current_user.definitions.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "定義の登録に失敗しました！"
      render 'toppages/index'
    end
  end
  
  def edit
    @definition = Definition.find(params[:id])
  end
  
  def update
    @definition = Definition.find(params[:id])
    if @definition.update(definition_params)
      flash[:success] = '定義を変更しました！'
      redirect_to current_user
    else
      @definitions = current_user.definitions.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "定義の変更に失敗しました！"
      render :edit
    end
  end
  
  def destroy
    @definition.destroy
    flash[:success] = '定義を削除しました！'
    redirect_to current_user
  end
  
  def import
    # fileはtmpに自動で一時保存される
    Definition.import(params[:file])
    flash[:success] = "定義をインポートしました！"
    redirect_to current_user
  end
  
  private

  def definition_params
    params.require(:definition).permit(:category_id, :term, :body)
  end
  
  def correct_user
    @definition = Definition.find(params[:id])
    redirect_to(current_user || root_url) if @definition.user != current_user
  end
  
  def my_definition
    @definition = Definition.find(params[:id])
    redirect_to(current_user || root_url) if !referenceable?(@definition.user)
  end
end
