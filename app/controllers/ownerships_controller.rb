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
end
