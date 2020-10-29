module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

# ユーザがログインしていればtyueを返す
  def logged_in?
    !!current_user
  end
end
