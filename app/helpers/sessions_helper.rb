module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def admin?(user)
    (user.admin == true) ? true : false
  end
  
  def referenceable?(user)
    if admin?(user) || (user == current_user)
      return true
    else
      return false
    end
  end
  
  def referenceable_ids
    User.where(admin: true).ids << current_user.id
  end
end
