class OwnershipsController < ApplicationController
  def create
    p params
    if params[:favorite].present? && params[:favorite][:type] == "favorite"
      @definition = Definition.find(params[:favorite][:definition_id])
      current_user.favorite(@definition)
    elsif params[:favorite].present? && params[:favorite][:type].nil?
      @definition = Definition.find(params[:favorite][:definition_id])
      current_user.unfavorite(@definition)
    elsif params[:memory].present? && params[:memory][:type] == "memory"
      @definition = Definition.find(params[:memory][:definition_id])
      current_user.memory(@definition)
    elsif params[:memory].present? && params[:memory][:type].nil?
      @definition = Definition.find(params[:memory][:definition_id])
      current_user.unmemory(@definition)
    end
  end
  
  def destroy
    if params[:type] == "memory"
      current_user.memories.destroy_all
    elsif params[:type] == "favorite"
      current_user.favorites.destroy_all
    end
    redirect_back(fallback_location: root_url)
  end
end
