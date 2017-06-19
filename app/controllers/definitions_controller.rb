class DefinitionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @definition = current_user.definitions.build
  end
  
  def create
    @definition = current_user.definitions.build(definition_params)
    if @definition.save
      flash[:success] = '定義を登録しました！'
      redirect_to root_url
    else
      @definitions = current_user.definitions.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "定義の登録に失敗しました！"
      render 'toppages/index'
    end
  end
  
  def edit
    @definition = current_user.definitions.find(params[:id])
  end
  
  def update
    @definition = current_user.definitions.find(params[:id])
     
    if @definition.update
      flash[:success] = '定義を変更しました！'
      redirect_to root_url
    else
      @definitions = current_user.definitions.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "定義の変更に失敗しました！"
      render :edit
    end
  end
  
  def destroy
    @definition.destroy
    flash[:success] = '定義を削除しました！'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def definition_params
    params.require(:definition).permit(:category_id, :term, :body)
  end
  
  def correct_user
    @definition = current_user.definitions.find_by(id: params[:id])
    unless @definition
      redirect_to root_path
    end
  end
  
end