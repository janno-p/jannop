module AuthenticationHelper
  def signed_in?
    !session[:user_id].nil? and !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def ensure_signed_in
    unless signed_in? then
      sign_out!
      session[:redirect_to] = request.fullpath
      flash[:notice] = "Please log in!"
      redirect_to(new_session_path)
    end
  end
  
  def ensure_user_active
    if signed_in? and not current_user.active? then
      sign_out!
      flash[:notice] = "User #{current_user.email} is not ativated yet. Try again later!"
      redirect_to(root_path)
    end
  end
  
  def sign_out!
    session[:user_id] = nil
  end
end
